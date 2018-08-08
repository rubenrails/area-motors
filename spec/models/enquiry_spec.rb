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

  describe '#status' do
    subject { described_class.new }

    describe '#invalidate' do
      it { is_expected.to transition_from(:new).to(:invalid).on_event(:invalidate) }
    end

    describe '#mark_as_done' do
      it { is_expected.to transition_from(:new).to(:done).on_event(:mark_as_done) }
    end

    describe '#expire' do
      it { is_expected.to transition_from(:new).to(:expired).on_event(:expire) }
    end

    describe '#mark_as_junk' do
      it { is_expected.to transition_from(:new).to(:junk).on_event(:mark_as_junk) }
      it { is_expected.to transition_from(:invalid).to(:junk).on_event(:mark_as_junk) }
    end

    describe '#reset' do
      it { is_expected.to transition_from(:invalid).to(:new).on_event(:reset) }
      it { is_expected.to transition_from(:done).to(:new).on_event(:reset) }
      it { is_expected.to transition_from(:expired).to(:new).on_event(:reset) }
      it { is_expected.to transition_from(:junk).to(:new).on_event(:reset) }
    end

    context 'when it is in initial NEW state' do
      subject { described_class.new }

      it { is_expected.to have_state(:new) }
      it { is_expected.to allow_event(:invalidate) }
      it { is_expected.to allow_event(:mark_as_done) }
      it { is_expected.to allow_event(:expire) }
      it { is_expected.to allow_event(:mark_as_junk) }
      it { is_expected.to_not allow_event(:reset) }
    end

    context 'when it is in INVALID state' do
      subject { described_class.new status: :invalid }

      it { is_expected.to have_state(:invalid) }
      it { is_expected.to allow_event(:mark_as_junk) }
      it { is_expected.to allow_event(:reset) }
      it { is_expected.to_not allow_event(:invalidate) }
      it { is_expected.to_not allow_event(:mark_as_done) }
      it { is_expected.to_not allow_event(:expire) }
    end

    context 'when it is in DONE state' do
      subject { described_class.new status: :done }

      it { is_expected.to have_state(:done) }
      it { is_expected.to allow_event(:reset) }
      it { is_expected.to_not allow_event(:invalidate) }
      it { is_expected.to_not allow_event(:mark_as_done) }
      it { is_expected.to_not allow_event(:expire) }
      it { is_expected.to_not allow_event(:mark_as_junk) }
    end

    context 'when it is in EXPIRED state' do
      subject { described_class.new status: :expired }

      it { is_expected.to have_state(:expired) }
      it { is_expected.to allow_event(:reset) }
      it { is_expected.to_not allow_event(:invalidate) }
      it { is_expected.to_not allow_event(:mark_as_done) }
      it { is_expected.to_not allow_event(:expire) }
      it { is_expected.to_not allow_event(:mark_as_junk) }
    end

    context 'when it is in JUNK state' do
      subject { described_class.new status: :junk }

      it { is_expected.to have_state(:junk) }
      it { is_expected.to allow_event(:reset) }
      it { is_expected.to_not allow_event(:invalidate) }
      it { is_expected.to_not allow_event(:mark_as_done) }
      it { is_expected.to_not allow_event(:expire) }
      it { is_expected.to_not allow_event(:mark_as_junk) }
    end
  end

end
