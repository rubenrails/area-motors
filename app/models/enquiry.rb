class Enquiry < ApplicationRecord
  belongs_to :source, class_name: 'Website'
  has_one :car_listing
end
