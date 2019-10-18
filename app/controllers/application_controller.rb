# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from(ActiveRecord::RecordNotFound) do
    render_404
  end

  rescue_from(ActionController::UnknownFormat) do
    render_404
  end

  private

  def render_404
    render json: { status: 'error', code: 404, message: 'Not found' }, status: 404
  end

  def render_400(message:)
    message ||= 'Bad request'

    render json: { status: 'error', code: 400, message: message }, status: 400
  end
end
