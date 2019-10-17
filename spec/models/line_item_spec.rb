require 'rails_helper'

RSpec.describe LineItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:ticket) }
    it { should belong_to(:order) }
  end

  describe 'validations' do
    it { should validate_presence_of(:ticket_id) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:event_name) }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  end

  describe '#full_price' do
    let(:line_item) { build(:line_item) }

    it 'returns price for all tickets' do
      line_item.quantity = 10
      line_item.unit_price = BigDecimal('10.00')

      expect(line_item.full_price).to eq(BigDecimal('100.00'))
    end
  end

  describe '#ticket_in_stock?' do
    let(:line_item) { build(:line_item) }

    it 'checks if tickets are available in a stock' do
      line_item.ticket.stock.available = 30

      line_item.quantity = 20
      expect(line_item.ticket_in_stock?).to eq(true)

      line_item.quantity = 31
      expect(line_item.ticket_in_stock?).to eq(false)
    end
  end
end
