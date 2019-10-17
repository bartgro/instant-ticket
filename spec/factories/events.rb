FactoryBot.define do
  factory :event do
    name { 'MyString' }
    start_at { 20.day.from_now }
    end_at { 22.day.from_now }

    trait :ends_before_start do
      start_at { '2019-10-09 13:22:28' }
      end_at { '2019-10-06 13:22:28' }
    end

    trait :future_event do
      start_at { 20.day.from_now }
      end_at { 21.day.from_now }
    end

    trait :past_event do
      start_at { 60.day.ago }
      end_at { 59.day.ago }
    end
  end
end
