FactoryBot.define do
  factory :stock do
    available { Faker::Number.within(range: 20..100) }
  end
end
