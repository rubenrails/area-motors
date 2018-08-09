class EnquiryParser < ApplicationService

  SOURCE_DIR = Rails.root.join("public", "enquiries").freeze
  FILE_PATTERN = "*.html".freeze
  ARCHIVE_DIR = File.join(SOURCE_DIR, "archived").freeze

  def initialize

  end

  def call
    list.each { |item| parse item }
  end


  private
  def list
    Dir[File.join(SOURCE_DIR, FILE_PATTERN)].map{ |f| File.expand_path(f) }
  end

  def parse enquiry_filepath
    doc = Nokogiri::HTML(open(enquiry_filepath))
    is_amdirect?(doc) ? parse_amdirect(doc) : parse_cars_for_sale(doc)
  end

  def parse_amdirect doc
    name = doc.css(".customer-details #name").first&.content
    email = doc.css(".customer-details #email").first&.content
    message = doc.xpath('//div/text()').to_s.strip

    ref = doc.css(".vehicle-details #listing-ref").first&.content
    make = doc.css(".vehicle-details #make").first&.content
    model = doc.css(".vehicle-details #make").last&.content # This is probably a finger-error while creating the enquiries. Should be id='model' instead.
    colour = doc.css(".vehicle-details #colour").last&.content
    year = doc.css(".vehicle-details #year").last&.content
    url = doc.css(".vehicle-details a").first.try(:[], :href)
  end

  def parse_cars_for_sale doc
    puts 'parse CarsForSale'
  end

  def archive! enquiry_filepath
    FileUtils.mv enquiry_filepath, ARCHIVE_DIR
  end

  def is_amdirect? doc
    doc.at('span:contains("Sent from AM-Direct")').present?
  end
end

