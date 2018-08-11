class Website < ApplicationRecord
  has_many :enquiries, foreign_key: "source_id"

  validates :name, :domain, presence: true

  def self.amdirect
    find_or_create_by name: 'AMDirect', domain: 'amdirect.test'
  end

  def self.carsforsale
    find_or_create_by name: 'CarsForSale', domain: 'carsforsale.test'
  end
end
