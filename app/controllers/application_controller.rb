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
    render json: { status: { error: { code: 404, message: 'Not found' } } }, status: 404
  end

  def render_error(code:, message:, status: 400)
    render json: { status: { error: { code: code, message: message } } }, status: status
  end
end
