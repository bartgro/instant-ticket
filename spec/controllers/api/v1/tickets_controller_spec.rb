require 'rails_helper'

RSpec.describe Api::V1::TicketsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    let(:ticket) { create(:ticket) }

    context 'when ticket can be found' do
      it "returns http success" do
        get :show, params: { id: ticket.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'when ticket cannot be found' do
      it "responses with error" do
        get :show, params: { id: 'whatever' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
