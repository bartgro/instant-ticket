FactoryBot.define do
  factory :line_item do
    unit_price { BigDecimal("10.00") }
    quantity { 1 }
    event_name { 'hackathon' }
    ticket { create(:ticket) }
  end
end
