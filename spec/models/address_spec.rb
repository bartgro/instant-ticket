require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'relationships' do
    it { should belong_to(:order) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:email) }
  end

  describe '#capitalize_attributes' do
    let(:order) { create(:order) }
    let(:address) { build(:address)}

    it 'formats attributes' do
      order.address.first_name = address.first_name
      order.address.last_name = address.last_name
      order.address.city = address.city
      order.address.country = address.country
      order.save

      expect(order.address.first_name[0]).to eq(order.address.first_name[0].upcase)
      expect(order.address.last_name[0]).to eq(order.address.last_name[0].upcase)
      expect(order.address.city[0]).to eq(order.address.city[0].upcase)
      expect(order.address.country[0]).to eq(order.address.country[0].upcase)
    end
  end
end
