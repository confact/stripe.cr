# Changelog

## v1.5

### API changes
- Remove deprecated [`Stripe::Plans`](https://stripe.com/docs/api/plans) (https://github.com/confact/stripe.cr/pull/55)
- Added support for [`Stripe::Coupon#retrieve`](https://stripe.com/docs/api/coupons/retrieve) (https://github.com/confact/stripe.cr/pull/43)

### Misc improvements
- Add metadata, subscription_data, and payment_method_types to Checkout::Session (https://github.com/confact/stripe.cr/pull/43)
- Added support for list helper method (https://github.com/confact/stripe.cr/pull/40)
- Add payment intent data to Checkout::Session (https://github.com/confact/stripe.cr/pull/52)
- Make request.id optional for `Stripe::Event` (https://github.com/confact/stripe.cr/pull/41)
- Update account_balance to balance for Customer (https://github.com/confact/stripe.cr/pull/50)
- Add promotion_code as discount to Checkout::Session (https://github.com/confact/stripe.cr/pull/49)
- Added support for delete helper method (https://github.com/confact/stripe.cr/pull/42)
- Fix bug with incorrect params in list helper method (https://github.com/confact/stripe.cr/pull/58)

## v1.4

### API additions

- Added support for [`Stripe::File`](https://stripe.com/docs/api/files) (https://github.com/confact/stripe.cr/pull/32)
- Added support for [`Stripe::FileLink`](https://stripe.com/docs/api/file_links) (https://github.com/confact/stripe.cr/pull/32)
- Added support for [`Stripe::Account`](https://stripe.com/docs/api/accounts) (https://github.com/confact/stripe.cr/pull/31)
- Added support for [`Event`](https://stripe.com/docs/api/events) objects (https://github.com/confact/stripe.cr/pull/26)
- Added support for verifying [webhooks](https://stripe.com/docs/webhooks/signatures) via `Stripe::Webhook` (https://github.com/confact/stripe.cr/pull/26)
- Updated [`Stripe::Charge`](https://stripe.com/docs/api/charges) (https://github.com/confact/stripe.cr/pull/30)
- Added support for [`Stripe::Product#list`](https://stripe.com/docs/api/skus/list#list_skus-product) (https://github.com/confact/stripe.cr/pull/25)

## v1.3

### Misc improvements

- Crystal v1.0 support added

## v1.2

### API updates

- Added support for [Attaching a Payment Method to a Customer](https://stripe.com/docs/api/payment_methods/attach) (https://github.com/confact/stripe.cr/pull/12)
- Added distinct object for [Discounts](https://stripe.com/docs/api/discounts) (https://github.com/confact/stripe.cr/pull/16)
- Added distinct object for [Prices](https://stripe.com/docs/api/prices) (https://github.com/confact/stripe.cr/pull/16)
- Added distinct object for [Promotion Codes](https://stripe.com/docs/api/promotion_codes) (https://github.com/confact/stripe.cr/pull/16)

### Misc improvements

- Supporting Crystal 0.36.1 (https://github.com/confact/stripe.cr/pull/17)
- Transition from Travis CI to GitHub Actions (https://github.com/confact/stripe.cr/pull/11)
- Automatically generate API documentation (https://github.com/confact/stripe.cr/pull/12)

## v1.1

- Supporting Crystal 0.35.1
- Added support for [Stripe Checkout](https://stripe.com/payments/checkout) (https://github.com/confact/stripe.cr/pull/7)
- Added support for [Invoice Line Item Creation](https://stripe.com/docs/api/invoiceitems/create) (https://github.com/confact/stripe.cr/pull/5)

## v1.0

- Added this changelog file
- Supporting Crystal 0.34
- Moving all structs to classes to fix compiler issues
- Changed structure of the calls, using class methods and class variables for api key. Will use less memory and be much cleaner.
- Added expand to these entities create methods: Customer, Charge, SetupIntent, PaymentIntent, and Token
- Made List Enumerable - So all Enumerable's methods works on lists

### Added api calls

- Create source
- Retrieve source
- Attach source to customer
- Detach source from customer
- Add tax id to a customer
- Remove tax id from customer
- Retrieve tax id from customer
- Retrieve charge
- create refund
- retrieve refund
- list customers
- list subscriptions
- list invoices
- list payment intents
- list setup intents
- create tax rate
- retrieve tax rate

### Added Entities

- Coupons
- Customer Tax ID
- Payout
- Source

## v0.2 (2020-03-31)

- Added some core entities
- Fixed bug in Charges
- Removed validations macro
- Added support for sending post params with array and array with Hashes/NamedTuples
- Added expand only on `create_subscription` method

### Added api calls

- payment/setup intent create
- payment/setup intent retrieve
- payment/setup intent confirm
- create product
- create plan

### Added Entities

- Payment Intent
- Setup Intent
- Plan
- Product
