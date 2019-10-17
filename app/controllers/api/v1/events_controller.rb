# frozen_string_literal: true

class Api::V1::EventsController < ApplicationController
  def index
    events = Event.includes(tickets: %i[stock]).order(:start_at)
    events = events.where('end_at >= ?', params[:from]) if params[:from].present?
    events = events.where('end_at <= ?', params[:to]) if params[:to].present?

    render json: events, include: [tickets: %i[stock]]
  end

  def show
    event = Event.includes(tickets: :stock).find(params[:id])

    render json: event, include: [tickets: %i[stock]]
  end
end
