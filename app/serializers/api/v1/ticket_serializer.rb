# frozen_string_literal: true

class Api::V1::TicketSerializer < ApplicationSerializer
  attributes :id, :type, :price

  has_one :stock

  def type
    object.kind
  end

  def price
    {
      amount: object.price,
      currency: 'EUR'
    }
  end
end
