# frozen_string_literal: true

class Stock < ApplicationRecord
  belongs_to :ticket

  validates :available, numericality: { greater_than_or_equal_to: 0 }
  validates :ticket_id, presence: true
end
