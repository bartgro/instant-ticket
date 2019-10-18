require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do

  describe "GET #index" do
    subject { create_items(:event, 4) }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    subject { create(:event) }

    it "returns http success" do
      get :show, params: { id: subject.id }
      expect(response).to have_http_status(:success)
    end

    context 'when event cannot be found' do
      it 'responses with not found' do
        get :show, params: { id: 'wrong id' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
