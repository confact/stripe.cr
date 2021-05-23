# https://stripe.com/docs/api/events/object
class Stripe::Event
  include JSON::Serializable

  class Request
    include JSON::Serializable
    getter id : String
    getter idempotency_key : String?
  end

  alias StripeObject = Stripe::Customer | Stripe::Product | Stripe::Invoice | Stripe::Subscription | Stripe::Price | Stripe::Coupon | Stripe::Plan | Stripe::Balance | Stripe::Charge | Stripe::Payout | Stripe::PaymentIntent | Stripe::SetupIntent | Stripe::PromotionCode | Stripe::Source | Stripe::TaxRate # | Stripe::Checkout::Session

  # missing Stripe objects to add : Stripe::Person | Stripe::File | Stripe::CreditNote | Stripe::Account | Stripe::Capability | Stripe::Identity | Stripe::InvoiceItem
  # all Stripe::Issuing objects | Stripe::Mandate | Stripe::Order | Stripe::OrderReturn | Stripe::Radar | Stripe::Recipient | Stripe::Reporting | Stripe::Review | Stripe::Sigma |
  # Stripe::Sku | Stripe::SubscriptionSchedule | Stripe::Topup | Stripe::Transfer |
  class Data
    include JSON::Serializable
    getter object : StripeObject
  end

  getter id : String
  getter api_version : String
  getter data : Data
  getter request : Request?
  getter object : String = "event"
  getter account : String?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  getter livemode : Bool?

  getter pending_webhooks : Int32

  getter type : String
end
