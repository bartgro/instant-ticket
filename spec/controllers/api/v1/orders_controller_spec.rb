require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do

  describe 'GET draft' do
    it 'returns http success' do
      get :draft
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:shipping_type) { create(:shipping_type) }
    let(:ticket) { create(:ticket) }
    let(:address) { attributes_for(:address) }

    it 'should create an order' do
      order_valid_params = {
        comment: 'comment',
        shipping_type_id: shipping_type.id,
        address_attributes: address,
        line_items_attributes: [
          { ticket_id: ticket.id },
          { quantity: 1 }
        ]
      }

      expect { post :create, params: { order: order_valid_params } }.
      to change { Order.count }.by(1)
    end

    it 'validates address attributes' do
      order_params = {
        comment: 'comment',
        shipping_type_id: shipping_type.id,
        address_attributes: address,
        line_items_attributes: [
          { ticket_id: ticket.id },
          { quantity: 1 }
        ]
      }

      order_params[:address_attributes][:first_name] = nil

      expect { post :create, params: { order: order_params } }.
      to change { Order.count }.by(0)
    end

    it 'validates line_items attributes' do
      order_params = {
        comment: 'comment',
        shipping_type_id: shipping_type.id,
        address_attributes: address,
        line_items_attributes: []
      }

      expect { post :create, params: { order: order_params } }.
      to change { Order.count }.by(0)
    end
  end

  describe 'POST #check_out' do
    let(:order) { create(:order) }

    context 'when order is realizable' do
      it 'responses with success' do
        post :check_out, params: { id: order.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'when customer try to check out order again' do
      it 'responses with error' do
        post :check_out, params: { id: order.id }
        post :check_out, params: { id: order.id }
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'POST #pay' do
    let(:order) { create(:order, :confirmed) }

    context 'when correct params are given' do
      it 'responses with success' do
        post :pay, params: { order_id: order.id, token: 'awesometoken' }
        expect(response).to have_http_status(200)
      end
    end

    context 'when order cannot be found' do
      it 'responses with error' do
        post :pay, params: { order_id: 'hello', token: 'awesometoken' }
        expect(response).to have_http_status(404)
      end
    end

    context 'where token is not a string' do
      it 'responses with error' do
        post :pay, params: { order_id: 'hello', token: 123 }
        expect(response).to have_http_status(404)
      end
    end

    context 'where token is not given' do
      it 'responses with error' do
        # byebug
        post :pay, params: { order_id: order.id, token: nil }
        expect(response).to have_http_status(404)
      end
    end
  end
end
