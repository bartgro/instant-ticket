# frozen_string_literal: true

class Ticket < ApplicationRecord
  has_one :stock, dependent: :delete
  belongs_to :event

  validates :event_id, :price, :kind, presence: true

  def in_stock?(quantity)
    quantity <= stock.available
  end
end
