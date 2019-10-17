# frozen_string_literal: true

class Api::V1::OrdersController < ApplicationController
  include Payment

  # GET api/v1/order/draft
  def draft
    render json: draft_order, serializer: Api::V1::DraftOrderSerializer
  end

  # POST /api/v1/order
  def create
    order = order_with_attributes

    if order.save
      render json: order
    else
      render_error code: 400, message: 'Params not valid.'
    end
  end

  # POST /api/v1/order/check-out
  def check_out
    order = Order.find(params[:id])

    if order.transition_to :confirmed
      render json: order, serializer: Api::V1::OrderCheckOutSerializer
    else
      render_error code: 400, message: 'Something went wrong, please check your order.'
    end
  end

  # POST /api/v1/order/pay
  def pay
    order = Order.find(params[:order_id])
    token = params[:token] if params[:token].instance_of?(String)

    if token.nil?
      render_404
    else
      Payment::Gateway.charge(amount: order.full_cost, token: token)
      order.transition_to :paid
    end
  rescue CardError => e
    render_error code: 400, message: e, status: 400
  rescue PaymentError => e
    render_error code: 400, message: e, status: 400
  end

  private

  def order_attributes
    params.require(:order).permit(
      :comment,
      :shipping_type_id,
      address_attributes: %I[first_name last_name address city country zip_code email phone order_id],
      line_items_attributes: %I[ticket_id quantity]
    )
  end

  def draft_order
    order = Order.new
    order.build_address
    order.line_items.build

    order
  end

  def order_with_attributes
    order = Order.new(order_attributes)
    order.assign_attributes(shipping_cost: order.shipping_type.cost)
    order.line_items.each do |i|
      i.assign_attributes(unit_price: i.ticket.price, event_name: i.ticket.event.name)
    end

    order
  end
end
