require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'relationships' do
    it { should have_many(:tickets).dependent(:delete_all) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_at) }
    it { should validate_presence_of(:end_at) }

    it 'is expected to validate that :start_at cannot be after :end_at' do
      event = build(:event, :ends_before_start)
      expect(event.save).to be(false)
    end
  end

  describe '#before_event?' do
    let(:past_event) { build(:event, :past_event) }
    let(:future_event) { build(:event, :future_event) }

    it 'checks if event is not ended' do
      expect(future_event.before_event?).to be(true)
      expect(past_event.before_event?).to be(false)
    end
  end
end
