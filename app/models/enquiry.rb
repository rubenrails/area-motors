class Enquiry < ApplicationRecord
  include AASM

  belongs_to :source, class_name: 'Website'
  has_one :car_listing, dependent: :destroy

  accepts_nested_attributes_for :car_listing, reject_if: :all_blank
  delegate :make, :model, :colour, :year, :reference, :url, to: :car_listing
  enum status: [:new, :invalid, :done, :expired, :junk], _suffix: true

  scope :new_status_first, -> { order(:status) }
  scope :oldest_first, -> { order(:created_at) }

  aasm column: :status, enum: true do
    state :new, initial: true
    state :invalid, :done, :expired, :junk

    event :invalidate do
      transitions from: :new, to: :invalid
    end

    event :mark_as_done do
      transitions from: :new, to: :done
    end

    event :expire do
      transitions from: :new, to: :expired
    end

    event :mark_as_junk do
      transitions from: [:new, :invalid], to: :junk
    end

    event :reset do
      transitions from: [:invalid, :done, :expired, :junk], to: :new
    end
  end

  def self.search query
    where("lower(name) LIKE :query OR lower(email) LIKE :query", query: "%#{query.downcase}%").distinct
  end
end
