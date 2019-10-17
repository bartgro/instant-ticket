# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :ticket
  belongs_to :order

  validates :ticket_id, :unit_price, :quantity, :event_name, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def full_price
    unit_price * quantity
  end

  def ticket_in_stock?
    ticket.in_stock?(quantity)
  end
end
