# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @order = order

    mail to: @order.address.email
  end

  def order_paid(order)
    @order = order

    mail to: @order.address.email
  end

  def order_in_progress(order)
    @order = order

    mail to: @order.address.email
  end

  def order_shipped(order)
    @order = order

    mail to: @order.address.email
  end

  def order_cancelled(order)
    @order = order

    mail to: @order.address.email
  end
end
