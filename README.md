# Stripe

Stripe API wrapper for Crystal.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  stripe:
    github: confact/stripe.cr
```

## Usage

```crystal
require "stripe"

stripe = Stripe.new("YOUR_API_TOKEN")

token = stripe.create_card_token(card: {
  number: "4242424242424242",
  exp_month: 12,
  exp_year: 2019,
  cvc: 123,
})

customer = stripe.create_customer(source: token)
charge = stripe.create_charge(amount: 1000, currency: "usd", customer: customer)
```

## Progress

### API methods

#### Core

##### Balance

- [x] Retrieve balance

- [ ] Retrieve a balance transaction

- [ ] List all balance history

##### Charges

- [x] Create a charge

- [ ] Retrieve a charge

- [ ] Update a charge

- [ ] Capture a charge

- [ ] List all charges

##### Subscriptions
- [x] Create a Subscription

- [x] Retrieve a Subscription

- [x] Update a Subscription

- [ ] Delete a Subscription

- [ ] List all Subscriptions

##### Setup Intent

- [x] Create a Setup Intent

- [x] Retrieve a Setup Intent

- [ ] Update a Setup Intent

- [ ] Delete a Setup Intent

- [ ] List all Setup Intents

##### Customers

- [x] Create a customer

- [x] Retrieve a customer

- [x] Update a customer

- [ ] Delete a customer

- [ ] List all customers

##### Tokens

- [x] Create a card token

- [ ] Create a bank account token

- [ ] Create a PII token

- [ ] Create an account token

- [ ] Retrieve a token

##### Invoices

- [x] Create a invoice

- [x] Retrieve a invoice

- [x] Update a invoice

- [ ] Delete a invoice

- [ ] List all invoices


### Objects

#### Core

- [x] Balance

- [ ] Balance transaction

- [x] Charge

- [x] Customer

- [ ] Dispute

- [ ] Dispute evidence

- [ ] Event

- [ ] File

- [ ] File link

- [ ] Payout

- [ ] Product

- [x] Refund

- [x] Token

#### Payment methods

- [x] Bank account

- [x] Card

- [ ] Source

#### Connect


- [ ] Account

- [ ] Login link

- [ ] Application fee refund

- [ ] Application fee

- [ ] Country spec

- [ ] Top-up

- [ ] Transfer

- [ ] Transfer reversal

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/confact/stripe.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [confact](https://github.com/confact) Håkan Nylén - maintainer,
- [vladfaust](https://github.com/vladfaust) Vlad Faust - creator
