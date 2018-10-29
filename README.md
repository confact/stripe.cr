# Stripe

Stripe API wrapper for Crystal.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  stripe:
    github: vladfaust/stripe.cr
```

## Usage

```crystal
require "stripe"

stripe = Stripe.new("YOUR_API_TOKEN")

token = stripe.create_card_token(card: Stripe::CreateCardToken::Card.new(
  number: "4242424242424242",
  exp_month: 12,
  exp_year: 2019,
  cvc: 123,
))

customer = stripe.create_customer(source: token)
charge = stripe.create_charge(amount: 1000, currency: "usd", customer: customer)
```

## Progress

### API methods

#### Core

##### Balance

☑️ Retrieve balance

⬜️ Retrieve a balance transaction

⬜️ List all balance history

##### Charges

☑️ Create a charge

⬜️ Retrieve a charge

⬜️ Update a charge

⬜️ Capture a charge

⬜️ List all charges

##### Customers

☑️ Create a customer

☑️ Retrieve a customer

⬜️ Update a customer

⬜️ Delete a customer

⬜️ List all customers

##### Tokens

☑️ Create a card token

⬜️ Create a bank account token

⬜️ Create a PII token

⬜️ Create an account token

⬜️ Retrieve a token

### Objects

#### Core

☑️ Balance

⬜️ Balance transaction

☑️ Charge

☑️ Customer

⬜️ Dispute

⬜️ Dispute evidence

⬜️ Event

⬜️ File

⬜️ File link

⬜️ Payout

⬜️ Product

☑️ Refund

☑️ Token

#### Payment methods

☑️ Bank account

☑️ Card

⬜️ Source

#### Connect


⬜️ Account

⬜️ Login link

⬜️ Application fee refund

⬜️ Application fee

⬜️ Country spec

⬜️ Top-up

⬜️ Transfer

⬜️ Transfer reversal

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/vladfaust/stripe.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [vladfaust](https://github.com/vladfaust) Vlad Faust - creator, maintainer
