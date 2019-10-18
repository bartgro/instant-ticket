# frozen_string_literal: true

class Api::V1::TicketsController < ApplicationController
  # GET /api/v1/tickets
  # GET /api/v1/events/{event_id}/tickets
  def index
    tickets = Ticket.includes(:event, :stock)
    tickets = tickets.find(params[:event_id]) if params[:event_id].present?

    render json: tickets
  end

  # GET /api/v1/tickets/:id
  def show
    ticket = Ticket.includes(:event, :stock).find(params[:id])

    render json: ticket
  end
end
