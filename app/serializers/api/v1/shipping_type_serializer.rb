# frozen_string_literal: true

class Api::V1::ShippingTypeSerializer < ApplicationSerializer
  attributes :id, :name, :price, :delivery_time

  def price
    {
      amount: object.cost,
      currency: 'EUR'
    }
  end
end
