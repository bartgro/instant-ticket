FactoryBot.define do
  factory :shipping_type do
    name { Faker::Games::Pokemon.name }
    cost { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    delivery_time { Faker::Number.within(range: 0..14) }
  end
end
