# frozen_string_literal: true

class Api::V1::LineItemSerializer < ApplicationSerializer
  attributes :unit_price, :quantity, :order_id, :event_name
end
