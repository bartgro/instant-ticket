FactoryBot.define do
  factory :ticket do
    kind { Faker::Name.first_name }
    price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    event

    after(:create) do |ticket|
      create :stock, ticket: ticket
    end
  end
end
