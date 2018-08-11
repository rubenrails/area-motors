class EnquiryParser < ApplicationService

  SOURCE_DIR = Rails.root.join("public", "enquiries").freeze
  FILE_PATTERN = "*.html".freeze
  ARCHIVE_DIR = File.join(SOURCE_DIR, "archived").freeze


  def call
    list.map { |item| parse item }
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
    Hash.new.tap do |hsh|
      hsh[:source] = Website.amdirect
      hsh[:name] = doc.css(".customer-details #name").first&.content
      hsh[:email] = doc.css(".customer-details #email").first&.content
      hsh[:message] = doc.xpath('//div/text()').to_s.strip

      hsh[:car_listing_attributes] = {}
      hsh[:car_listing_attributes][:reference] = doc.css(".vehicle-details #listing-ref").first&.content
      hsh[:car_listing_attributes][:make] = doc.css(".vehicle-details #make").first&.content
      hsh[:car_listing_attributes][:model] = doc.css(".vehicle-details #make").last&.content # This is probably a finger-error while creating the enquiries. Should be id='model' instead.
      hsh[:car_listing_attributes][:colour] = doc.css(".vehicle-details #colour").last&.content
      hsh[:car_listing_attributes][:year] = doc.css(".vehicle-details #year").last&.content
      hsh[:car_listing_attributes][:url] = doc.css(".vehicle-details a").first.try(:[], :href)
    end
  end

  def parse_cars_for_sale doc
    regex = /^(.*)\((.*)\)(?:.*He asked:)(.*)(?:You can view the vehicle)/
    text = doc.xpath('//div/h1/following-sibling::text()').text.squish
    _, name, email, message = text.match(regex).to_a.map(&:squish)
    Hash.new.tap do |hsh|
      hsh[:source] = Website.carsforsale
      hsh[:name] = name
      hsh[:email] = email
      hsh[:message] = message

      hsh[:car_listing_attributes] = {}
      hsh[:car_listing_attributes][:make] = doc.at("td:contains('Make:')").next_element.text
      hsh[:car_listing_attributes][:model] = doc.at("td:contains('Model:')").next_element.text
      hsh[:car_listing_attributes][:colour] = doc.at("td:contains('Colour:')").next_element.text
      hsh[:car_listing_attributes][:year] = doc.at("td:contains('Year:')").next_element.text
      hsh[:car_listing_attributes][:url] = doc.css("div a").first.try(:[], :href)
    end
  end

  def archive! enquiry_filepath
    FileUtils.mv enquiry_filepath, ARCHIVE_DIR
  end

  def is_amdirect? doc
    doc.at('span:contains("Sent from AM-Direct")').present?
  end
end

