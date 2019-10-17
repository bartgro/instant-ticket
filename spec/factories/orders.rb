FactoryBot.define do
  factory :order do
    comment         { 'Need this ticket asap' }
    shipping_cost   { BigDecimal('10.00') }
    shipping_type   { create(:shipping_type) }

    add_attribute(:address)     { build(:address) }
    add_attribute(:line_items)  { build_list(:line_item, 2) }

    trait :confirmed do
      after(:create) do |order|
        order.transition_to! :confirmed
      end
    end

    trait :paid do
      after(:create) do |order|
        order.transition_to! :confirmed
        order.transition_to! :paid
      end
    end

    trait :in_progress do
      after(:create) do |order|
        order.transition_to! :confirmed
        order.transition_to! :paid
        order.transition_to! :in_progress
      end
    end

    trait :shipped do
      after(:create) do |order|
        order.transition_to! :confirmed
        order.transition_to! :paid
        order.transition_to! :in_progress
        order.transition_to! :shipped
      end
    end
  end

  factory :order_create_params do
    comment { 'a nice comment' }
    shipping_type { create(:shipping_type) }

    add_attribute(:address) { build(:address) }
    add_attribute(:line_items)  { build_list(:line_item, 2) }
  end
end
