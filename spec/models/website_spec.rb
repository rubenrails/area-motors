require 'rails_helper'

RSpec.describe Website, type: :model do

  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '#domain' do
    it { is_expected.to validate_presence_of(:domain) }
  end

end
