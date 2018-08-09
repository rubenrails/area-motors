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
    regex = /^(.*)\((.*)\)(?:.*He asked:)(.*)(?:You can view the vehicle)/
    text = doc.xpath('//div/h1/following-sibling::text()').text.squish
    _, name, email, message = text.match(regex).to_a.map(&:squish)

    make = doc.at("td:contains('Make:')").next_element.text
    model = doc.at("td:contains('Model:')").next_element.text
    colour = doc.at("td:contains('Colour:')").next_element.text
    year = doc.at("td:contains('Year:')").next_element.text
    url = doc.css("div a").first.try(:[], :href)
  end

  def archive! enquiry_filepath
    FileUtils.mv enquiry_filepath, ARCHIVE_DIR
  end

  def is_amdirect? doc
    doc.at('span:contains("Sent from AM-Direct")').present?
  end
end

