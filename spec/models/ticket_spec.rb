require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'relationships' do
    it { should have_one(:stock) }
    it { should belong_to(:event) }
  end

  describe 'validations' do
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:kind) }
    it { should validate_presence_of(:event_id) }
  end

  describe '#in_stock?' do
    let(:ticket) { create(:ticket) }

    it 'checks if there are available tickets in the stock' do
      ticket.stock.update(available: 30)
      expect(ticket.in_stock?(30)).to eq(true)
      expect(ticket.in_stock?(31)).to eq(false)
    end
  end
end
