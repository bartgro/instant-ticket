# frozen_string_literal: true

class Order < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries

  belongs_to :shipping_type
  has_many :line_items, inverse_of: :order
  has_many :transitions, class_name: 'OrderTransition', autosave: false
  has_one :address, inverse_of: :order

  accepts_nested_attributes_for :address, :line_items

  validates :shipping_type_id, :line_items, :address, presence: true

  delegate :can_transition_to?, :in_state?, :transition_to!, :transition_to, :current_state,
           to: :state_machine

  def state_machine
    @state_machine ||= OrderStateMachine.new(self, transition_class: OrderTransition, association_name: :transitions)
  end

  def full_cost
    line_items.map(&:full_price).sum + shipping_cost
  end

  def realizable?
    tickets_in_stock? && before_events?
  end

  def reallocate_stock
    line_items.group(:ticket_id).sum(:quantity).each do |ticket_id, quantity|
      stock = Ticket.find(ticket_id).stock

      available_tickets = stock.available

      if in_state?(:new)
        available_tickets -= quantity
      else
        available_tickets += quantity
      end

      stock.update(available: available_tickets)
    end
  end

  # private? || not private?

  def tickets_in_stock?
    hash = line_items.group(:ticket_id).sum(:quantity)

    return false unless hash.each do |id, quantity|
      return false unless Ticket.find(id).in_stock?(quantity)
    end

    true
  end

  def before_events?
    line_items.each do |item|
      return false unless item.ticket.event.before_event?
    end

    true
  end

  class << self
    def transition_class
      OrderTransition
    end

    def initial_state
      OrderStateMachine.initial_state
    end

    def transition_name
      :transitions
    end
  end
end
