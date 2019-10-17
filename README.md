# Instant-Ticket

## Installation

Clone repository

```Shell
git clone git@github.com:bartgro/instant-ticket.git && cd instant-ticket
```

Install dependencies

```Shell
bundle install
```

Configure database

```Shell
mv config/database.yaml.example config/database.yaml
```

Prepare database and fill with fake content

```Shell
rake db:create db:migrate db:seed
```

## Description

High-level features:

- Get info about events and their tickets (their availability in the stock), filter them
- Get info about certain event
- Get info about delivery methods
- Get list of tickets of certain event
- Purchase many tickets when available which means:

  - quantity of ordered tickets must be in the stock
  - you can order tickets only before an event ends

- Notify customer via email when order changes it's state
- Create, check out, pay for an order
- Reallocate stock on confirm / cancel order
- Validates and formats attributes
