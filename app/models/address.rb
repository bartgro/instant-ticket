# frozen_string_literal: true

class Address < ApplicationRecord
  before_save :capitalize_attributes

  belongs_to :order

  validates :first_name,
            :last_name,
            :address,
            :zip_code,
            :city,
            :country,
            :email, presence: true

  private

  def capitalize_attributes
    first_name.capitalize!
    last_name.capitalize!
    city.capitalize!
    country.capitalize!
  end
end
