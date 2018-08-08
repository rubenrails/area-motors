class Enquiry < ApplicationRecord
  belongs_to :source, class_name: 'Website'
  has_one :car_listing

  accepts_nested_attributes_for :car_listing, reject_if: :all_blank

  delegate :make, :model, :colour, :year, :reference, :url, to: :car_listing

  enum status: [:new, :invalid, :done, :expired, :junk], _prefix: true
end
