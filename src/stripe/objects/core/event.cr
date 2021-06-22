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

    @[JSON::Field(converter: Stripe::EventPayloadObjectConverter)]
    getter object : StripeObject

    # @[JSON::Field(ignore)]
    getter previous_attributes : JSON::Any?
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

STRIPE_OBJECT_TYPES = [
  "customer",
  "product",
  "invoice",
  "subscription",
  "price",
  "coupon",
  "plan",
  "balance",
  "charge",
  "payout",
  "payment_intent",
  "setup_intent",
  "promotion_code",
  "source",
  "tax_rate",
]

macro stripe_object_mapping
       {% begin %}
      {
        {% for item in STRIPE_OBJECT_TYPES %}
    {{item.id}}: {{"Stripe::#{item.camelcase.id}".id}},
  {% end %}
      }
 {% end %}
  end

module Stripe::EventPayloadObjectConverter
  def self.from_json(value : JSON::PullParser)
    object_json = value.read_raw
    object_identifier = JSON.parse(object_json)["object"].to_s
    stripe_object_mapping[object_identifier].from_json(object_json)
  rescue
    puts value.read_raw
  end
end
