# frozen_string_literal: true

class Api::V1::OrderSerializer < ApplicationSerializer
  attributes :id, :comment, :shipping_type_id, :shipping_cost, :summary

  has_one :address
  has_many :line_items

  def summary
    {
      full_cost: {
        amount: object.full_cost,
        currency: 'EUR'
      }
    }
  end
end
