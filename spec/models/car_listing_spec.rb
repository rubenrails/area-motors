require 'rails_helper'

RSpec.describe CarListing, type: :model do

  describe '#enquiry' do
    it { is_expected.to validate_presence_of(:enquiry) }
  end

end
