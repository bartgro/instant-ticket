# frozen_string_literal: true

class Api::V1::ShippingTypesController < ApplicationController
  def index
    shipping_types = ShippingType.all

    render json: shipping_types
  end
end
