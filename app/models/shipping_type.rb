# frozen_string_literal: true

class ShippingType < ApplicationRecord
  has_many :orders

  validates :name, :cost, :delivery_time, presence: true
end
