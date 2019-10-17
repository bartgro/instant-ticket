# Generate data for:
# - Event
# - Ticket
# - Stock
# - ShippingType

# Past event
Event.create! do |event|
  event.name = Faker::Games::Pokemon.name
  event.start_at = Faker::Date.between(from: 50.days.ago, to: 41.days.ago)
  event.end_at = Faker::Date.between(from: 40.days.ago, to: 39.days.ago)
  event.description = Faker::Hacker.say_something_smart
end

# Future events
3.times do
  Event.create! do |event|
    event.name = Faker::Games::Pokemon.name
    event.start_at = Faker::Date.between(from: 30.days.from_now, to: 40.days.from_now)
    event.end_at = Faker::Date.between(from: 41.days.from_now, to: 50.days.from_now)
    event.description = Faker::Hacker.say_something_smart
  end
end

# Tickets for each event
Event.all.each do |event|
  3.times do
    t = Ticket.create! do |ticket|
      ticket.kind = Faker::Creature::Animal.name
      ticket.price = Faker::Number.decimal(l_digits: 2, r_digits: 2)
      ticket.event_id = event.id
    end

    Stock.create! do |stock|
      stock.available = Faker::Number.within(range: 20..100)
      stock.ticket_id = t.id
    end
  end
end

ShippingType.create! do |shipping_type|
  shipping_type.name = 'carrier pigeon'
  shipping_type.cost = Faker::Number.decimal(l_digits: 1, r_digits: 2)
  shipping_type.delivery_time = Faker::Number.within(range: 0..14)
end

ShippingType.create! do |shipping_type|
  shipping_type.name = 'courier'
  shipping_type.cost = Faker::Number.decimal(l_digits: 1, r_digits: 2)
  shipping_type.delivery_time = Faker::Number.within(range: 0..14)
end

puts 'Success!'
