class Website < ApplicationRecord
  has_many :enquiries, foreign_key: "source_id"

  validates :name, :domain, presence: true

  def self.amdirect
    find_by domain: 'amdirect.test'
  end

  def self.carsforsale
    find_by domain: 'carsforsale.test'
  end
end
