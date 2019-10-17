FactoryBot.define do
  factory :address do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.street_address }
    zip_code { Faker::Address.zip_code }
    city { Faker::Address.city }
    country { Faker::Address.country }
    email { Faker::Internet.email }
    phone { Faker::Number.number.to_s }

    trait(:downcase) do
      first_name { Faker::Name.first_name.downcase }
      last_name { Faker::Name.last_name.downcase }
      city { Faker::Address.city.downcase }
      country { Faker::Address.country.downcase }
    end
  end
end
