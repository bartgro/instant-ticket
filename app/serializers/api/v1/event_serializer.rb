# frozen_string_literal: true

class Api::V1::EventSerializer < ApplicationSerializer
  attributes :id, :name, :start_at, :end_at, :description

  has_many :tickets
end
