# Stripe

Stripe API wrapper for Crystal.

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

### custom API version

You can set custom api version if needed.

```crystal
require "stripe"

stripe = Stripe.new("YOUR_API_TOKEN", "2019-03-29")
```

### Example of setting up a subscription

Here is a simple way to setup a subscription by using payment_method.

Follow the instruction for setting up an subscription at stripe: [https://stripe.com/docs/billing/subscriptions/set-up-subscription](https://stripe.com/docs/billing/subscriptions/set-up-subscription)

When the step is at server code, check the code below that is corresponding towards the ruby code for same step.

Setting up an customer:
```crystal
  token = params['StripeToken'] # or what the param for the token is called for you.
  customer = stripe.create_customer(email: email,
                         description: name, # just example
                         payment_method: token, # or token.payment_method.id  
                         # depends what you do in the frontend to handle the token.
                         invoice_settings: { default_payment_method: token })

```

create a subscription with that customer:
```crystal
stripe.create_subscription(customer: customer,
plan: STRIPE_PLAN_ID,
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

- [ ] Retrieve a charge

- [ ] Update a charge

- [ ] Capture a charge

- [ ] List all charges

##### Subscriptions
- [x] Create a Subscription

- [x] Retrieve a Subscription

- [x] Update a Subscription

- [x] Delete a Subscription

- [ ] List all Subscriptions

##### Setup Intent

- [x] Create a Setup Intent

- [x] Retrieve a Setup Intent

- [x] Confirm a Setup Intent

- [ ] Update a Setup Intent

- [ ] Cancel a Setup Intent

- [ ] Delete a Setup Intent

- [ ] List all Setup Intents

##### Payment Intent

- [x] Create a Payment Intent

- [x] Retrieve a Payment Intent

- [x] Confirm a Payment Intent

- [ ] Update a Payment Intent

- [ ] Cancel a Payment Intent

- [ ] Delete a Payment Intent

- [ ] List all Payment Intents

##### Customers

- [x] Create a customer

- [x] Retrieve a customer

- [x] Update a customer

- [x] Delete a customer

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

- [x] Plan

- [x] Product

- [x] Customer

- [x] Subscription

- [x] Invoice

- [ ] Dispute

- [ ] Dispute evidence

- [ ] Event

- [ ] File

- [ ] File link

- [ ] Payout

- [x] Refund

- [x] Token

- [x] Payment Intent

- [x] Setup Intent

#### Payment methods

- [x] Payment Method

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
