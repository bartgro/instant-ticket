# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :tickets, dependent: :delete_all

  validates :name, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true

  validate :end_after_start

  def before_event?
    DateTime.now < end_at
  end

  private

  def end_after_start
    return unless end_at.present? || start_at.present?

    errors.add(:end_at, 'Event cannot ends before it starts') if end_at < start_at
  end
end
