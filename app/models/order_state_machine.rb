# frozen_string_literal: true

class OrderStateMachine
  include Statesman::Machine

  state :new, initial: true
  state :confirmed
  state :paid
  state :in_progress
  state :shipped
  state :cancelled

  transition from: :new, to: %i[confirmed cancelled]
  transition from: :confirmed, to: %i[paid cancelled]
  transition from: :paid, to: %i[in_progress cancelled]
  transition from: :in_progress, to: %i[shipped cancelled]
  transition from: :shipped, to: %i[cancelled]

  guard_transition(to: :confirmed) do |order, _transition|
    order.realizable?
  end

  before_transition(to: :confirmed) do |order, _transition|
    order.reallocate_stock
  end

  before_transition(to: :cancelled) do |order, _transition|
    order.reallocate_stock
  end

  after_transition(to: :confirmed) do |order, _transition|
    OrderMailer.order_confirmation(order).deliver
  end

  after_transition(to: :paid) do |order, _transition|
    OrderMailer.order_paid(order).deliver
  end

  after_transition(to: :in_progress) do |order, _transition|
    OrderMailer.order_in_progress(order).deliver
  end

  after_transition(to: :shipped) do |order, _transition|
    OrderMailer.order_shipped(order).deliver
  end

  after_transition(to: :cancelled) do |order, _transition|
    OrderMailer.order_cancelled(order).deliver
  end
end
