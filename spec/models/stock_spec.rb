require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'relationships' do
    it { should belong_to(:ticket) }
  end

  describe 'validations' do
    it { should validate_presence_of(:ticket_id) }
    it { should validate_numericality_of(:available).is_greater_than_or_equal_to(0) }
  end
end
