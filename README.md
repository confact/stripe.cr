# Stripe

![Shard CI](https://github.com/confact/stripe.cr/workflows/Shard%20CI/badge.svg)
[![API Documentation Website](https://img.shields.io/website?down_color=red&down_message=Offline&label=API%20Documentation&up_message=Online&url=https%3A%2F%2Fconfact.github.io%2Fstripe.cr%2F)](https://confact.github.io/stripe.cr)
[![GitHub release](https://img.shields.io/github/release/confact/stripe.cr.svg?label=Release)](https://github.com/confact/stripe.cr/releases)

Stripe API wrapper for Crystal.

This version (>1.0) is changed to follow Ruby's method and class structure. We will follow `Stripe::Class.method` but follow crystal parameters to take care of the types automatically.

### Notice

This api wrapper was tested on api version `2020-03-02` but have been trying to make it flexible with `String?` and correspondent in the types.

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

Stripe.api_key = "YOUR_API_TOKEN"

token = Stripe::Token.create(card: {
  number: "4242424242424242",
  exp_month: 12,
  exp_year: 2019,
  cvc: 123,
})

customer = Stripe::Customer.create(source: token)
charge = Stripe::Charge.create(amount: 1000, currency: "usd", customer: customer)
```

### custom API version

You can set custom api version if needed.
Version need to be set before first api call is called. otherwise it won't be used.

```crystal
require "stripe"

Stripe.api_key = "YOUR_API_TOKEN"
Stripe.version = "2019-03-29"
```

### Example of setting up a subscription

Here is a simple way to setup a subscription by using payment_method.

Follow the instruction for setting up an subscription at stripe: [https://stripe.com/docs/billing/subscriptions/set-up-subscription](https://stripe.com/docs/billing/subscriptions/set-up-subscription)

When the step is at server code, check the code below that is corresponding towards the ruby code for same step.

Setting up an customer:

```crystal
  token = params['StripeToken'] # or what the param for the token is called for you.
  customer = Stripe::Customer.create(email: email,
                         description: name, # just example
                         payment_method: token, # or token.payment_method.id
                         # depends what you do in the frontend to handle the token.
                         invoice_settings: { default_payment_method: token })

```

create a subscription with that customer:

```crystal
Stripe::Subscription.create(customer: customer,
expand: ["latest_invoice.payment_intent"]) # yes - create_subscription support expand.
```

The rest is frontend to check SCA and more. You should not need to do more than this on the backend.

But follow [https://stripe.com/docs/billing/subscriptions/set-up-subscription](https://stripe.com/docs/billing/subscriptions/set-up-subscription) for the frontend part to make sure it works for SCA and other things.

## Progress

### API methods

#### Core

##### Balance

- [x] Retrieve balance

- [ ] Retrieve a balance transaction

- [ ] List all balance history

##### Charges

- [x] Create a charge

- [x] Retrieve a charge

- [ ] Update a charge

- [ ] Capture a charge

- [ ] List all charges

##### Sources

- [x] Create a source

- [x] Retrieve a source

- [x] Attach a source to customer

- [x] Detach a source from customer

- [ ] Update a source

##### Subscriptions

- [x] Create a Subscription

- [x] Retrieve a Subscription

- [x] Update a Subscription

- [x] Delete a Subscription

- [x] List all Subscriptions

##### Setup Intent

- [x] Create a Setup Intent

- [x] Retrieve a Setup Intent

- [x] Confirm a Setup Intent

- [ ] Update a Setup Intent

- [ ] Cancel a Setup Intent

- [ ] Delete a Setup Intent

- [x] List all Setup Intents

##### Payment Intent

- [x] Create a Payment Intent

- [x] Retrieve a Payment Intent

- [x] Confirm a Payment Intent

- [ ] Update a Payment Intent

- [ ] Cancel a Payment Intent

- [ ] Delete a Payment Intent

- [x] List all Payment Intents

##### Customers

- [x] Create a customer

- [x] Retrieve a customer

- [x] Update a customer

- [x] Delete a customer

- [x] List all customers

##### Customer Tax IDs

- [x] Create a customer tax ID

- [x] Retrieve a customer tax ID

- [x] Delete a customer tax ID

##### Refund

- [x] Create a refund

- [x] Retrieve a refund

- [ ] Update a refund

- [ ] List all refunds

##### Tax Rate

- [x] Create a tax rate

- [x] retrieve a tax rate

- [ ] Update a tax rate

- [ ] List all tax rates

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

- [x] List all invoices
##### Files

- [ ] Create a file

- [x] Retrieve a file

- [ ] Update a file

- [ ] List all files
##### File Links

- [ ] Create a file link

- [x] Retrieve a file link

- [ ] Update a file link

- [ ] List all file links

### Objects

#### Core

- [x] Balance

- [ ] Balance transaction

- [x] Charge

- [x] Product

- [x] Customer

- [x] Customer Tax ID

- [x] Subscription

- [x] Invoice

- [ ] Dispute

- [ ] Dispute evidence

- [x] Event

- [X] File

- [X] File link

- [ ] Payout

- [x] Refund

- [x] Tax Rate

- [x] Token

- [x] Payment Intent

- [x] Setup Intent

#### Payment methods

- [x] Payment Method

- [x] Bank account

- [x] Card

- [x] Source

- [x] Attach a payment method to a customer

#### Connect

- [x] Account

- [ ] Login link

- [ ] Application fee refund

- [ ] Application fee

- [ ] Country spec

- [ ] Top-up

- [ ] Transfer

- [ ] Transfer reversal

##### Prices

- [ ] Create a price

- [ ] Retrieve a price

- [ ] Update a price

- [x] List all prices

##### Products

- [x] Create a product

- [ ] Retrieve a product

- [ ] Update a product

- [x] List all products

##### Discounts

- [ ] Create a discount

- [ ] Retrieve a discount

- [ ] Update a discount

- [ ] List all discounts

##### Promotion codes

- [ ] Create a promotion code

- [ ] Retrieve a promotion code

- [ ] Update a promotion codes

- [ ] List all promotion codes

##### Coupons

- [ ] Create a coupon

- [ ] Retrieve a coupon

- [ ] Update a coupon

- [ ] List all coupons

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
