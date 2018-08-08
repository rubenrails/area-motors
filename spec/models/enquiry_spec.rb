require 'rails_helper'

RSpec.describe Enquiry, type: :model do

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:car_listing) }
  end

  describe 'delegation' do
    it { is_expected.to delegate_method(:make).to(:car_listing) }
    it { is_expected.to delegate_method(:model).to(:car_listing) }
    it { is_expected.to delegate_method(:colour).to(:car_listing) }
    it { is_expected.to delegate_method(:year).to(:car_listing) }
    it { is_expected.to delegate_method(:reference).to(:car_listing) }
    it { is_expected.to delegate_method(:url).to(:car_listing) }
  end

end
