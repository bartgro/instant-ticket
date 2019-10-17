require 'rails_helper'

RSpec.describe Order, type: :model do

  it 'has a proper initial state' do
    expect(Order.new.current_state).to eq('new')
  end

  describe 'relationships' do
    it { should belong_to(:shipping_type) }
    it { should have_many(:line_items) }
    it { should have_many(:transitions) }
    it { should have_one(:address) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:address) }
    it { should accept_nested_attributes_for(:line_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:shipping_type_id) }
    it { should validate_presence_of(:line_items) }
    it { should validate_presence_of(:address) }
  end

  describe 'delegations' do
    it { should delegate_method(:can_transition_to?).to(:state_machine) }
    it { should delegate_method(:in_state?).to(:state_machine) }
    it { should delegate_method(:transition_to!).to(:state_machine) }
    it { should delegate_method(:transition_to).to(:state_machine) }
    it { should delegate_method(:current_state).to(:state_machine) }
  end

  describe '#full_cost' do
    let(:order) { create(:order) }

    it 'sums all order costs' do
      full_cost = order.line_items.sum('quantity * unit_price') + order.shipping_cost

      expect(order.full_cost).to eq(full_cost)
    end
  end

  describe '#tickets_in_stock?' do
    let(:order) { create(:order) }

    it 'checks if tickets are available in the stock' do
      tickets = order.line_items.group(:ticket_id).sum(:quantity)
      tickets.each do |ticket_id, quantity|
        ticket = Ticket.find(ticket_id)
        expect(ticket.stock.available).to be >= quantity
      end
    end
  end

  describe '.transition_class' do
    it 'returns instance of OrderTransition' do
      expect(Order.transition_class).to be(OrderTransition)
    end
  end

  describe '.initial_state' do
    it 'should return :new state' do
      expect(Order.initial_state).to eq('new')
    end
  end

  describe '.transition_name' do
    it 'returns a name of transition' do
      expect(Order.transition_name).to eq(:transitions)
    end
  end
end
