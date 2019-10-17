require 'rails_helper'

RSpec.describe ShippingType, type: :model do
  describe 'relationships' do
    it { should have_many(:orders) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cost) }
    it { should validate_presence_of(:delivery_time) }
  end
end
