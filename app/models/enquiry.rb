class Enquiry < ApplicationRecord
  belongs_to :source, class_name: 'Website'
  has_one :car_listing

  delegate :make, :model, :colour, :year, :reference, :url, to: :car_listing
end
