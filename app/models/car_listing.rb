class CarListing < ApplicationRecord
  belongs_to :enquiry

  validates :enquiry, presence: true
end
