# frozen_string_literal: true

class Api::V1::OrderCheckOutSerializer < ApplicationSerializer
  attributes :status, :summary

  def status
    {
      code: 200,
      message: 'Order confirmed'
    }
  end

  def summary
    {
      full_price: { amount: object.full_cost, currency: 'EUR' },
      href: pay_api_v1_orders_path
    }
  end
end
