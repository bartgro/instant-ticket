require 'rails_helper'

RSpec.describe Api::V1::ShippingTypesController, type: :controller do

  describe "GET #index" do
    subject { create_list(:shipping_type, 4) }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
