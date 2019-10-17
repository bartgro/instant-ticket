# frozen_string_literal: true

class Api::V1::AddressSerializer < ApplicationSerializer
  attributes :first_name,
             :last_name,
             :address,
             :zip_code,
             :city,
             :country,
             :email,
             :phone,
             :order_id
end
