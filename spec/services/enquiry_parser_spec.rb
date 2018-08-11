require 'rails_helper'

RSpec.describe EnquiryParser, type: :service do

  describe '#call' do
    subject { described_class.new }

    context 'when there arent any new enquiries' do
      before(:each) do
        allow(subject).to receive(:list).and_return []
      end
      it 'returns and empty array' do
        expect(subject.call).to be_empty
      end
    end

    context 'when there are new enquiries' do
      before(:each) do
        stub_const "#{EnquiryParser}::SOURCE_DIR", Rails.root.join("spec", "fixtures")
      end
      it 'returns an array of hashes' do
        expect(subject.call).to match_array [amdirect_sample_params, carsforsale_sample_params]
      end
    end
  end

  def sample_enquiry_params
    {
      name: 'Arthur Dent',
      email: 'arthur@earth.com',
      message: 'Is there any tea on this spaceship?',
      car_listing_attributes: {
        make: 'H2G2',
        model: 'The Heart of Gold',
        year: '42',
        colour: 'White'
      }
    }
  end

  def amdirect_sample_params
    sample_enquiry_params.tap do |hsh|
      hsh[:source] = Website.amdirect
      hsh[:car_listing_attributes][:reference] = 'H2G2-001'
      hsh[:car_listing_attributes][:url] = '/amdirect_sample.html'
    end
  end

  def carsforsale_sample_params
    sample_enquiry_params.tap do |hsh|
      hsh[:source] = Website.carsforsale
      hsh[:car_listing_attributes][:url] = '/carsforsale_sample.html'
    end
  end

end
