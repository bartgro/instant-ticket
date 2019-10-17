require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do

  describe "GET #index" do
    subject { create_items(:event, 4) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    subject { create(:event) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
