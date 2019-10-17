require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  describe 'order_confirmation' do
    let(:order) { build(:order) }
    let(:mail) { OrderMailer.order_confirmation(order) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Instant-Ticket - Order confirmation')
      expect(mail.to).to eq([order.address.email])
      expect(mail.from).to eq(['from@example.com'])
    end
  end

  describe 'order_paid' do
    let(:order) { build(:order) }
    let(:mail) { OrderMailer.order_paid(order) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Instant-Ticket - Thanks for your purchase!')
      expect(mail.to).to eq([order.address.email])
      expect(mail.from).to eq(['from@example.com'])
    end
  end

  describe 'order_in_progress' do
    let(:order) { build(:order) }
    let(:mail) { OrderMailer.order_in_progress(order) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Instant-Ticket - We are preparing your order')
      expect(mail.to).to eq([order.address.email])
      expect(mail.from).to eq(['from@example.com'])
    end
  end

  describe 'order_shipped' do
    let(:order) { build(:order) }
    let(:mail) { OrderMailer.order_shipped(order) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Instant-Ticket - Your order has been shipped')
      expect(mail.to).to eq([order.address.email])
      expect(mail.from).to eq(['from@example.com'])
    end
  end

  describe 'order_cancelled' do
    let(:order) { build(:order) }
    let(:mail) { OrderMailer.order_cancelled(order) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Instant-Ticket - Your order has been cancelled')
      expect(mail.to).to eq([order.address.email])
      expect(mail.from).to eq(['from@example.com'])
    end
  end
end
