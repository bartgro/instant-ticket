# frozen_string_literal: true

class Api::V1::DraftOrderSerializer < ApplicationSerializer
  attributes :comment, :shipping_type_id, :shipping_cost, :summary

  has_one :address, key: :address_attributes
  has_many :line_items, key: :line_items_attributes

  def summary
    nil
  end
end
