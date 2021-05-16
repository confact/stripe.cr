# https://stripe.com/docs/api/events/object
class Stripe::Event
  include JSON::Serializable

  class Request
    include JSON::Serializable
    getter id : String
    getter idempotency_key : String?
  end

  alias StripeObject = Stripe::Product | Stripe::Invoice | Stripe::Subscription | Stripe::Price | Stripe::Coupon | Stripe::Plan

  class Data
    include JSON::Serializable
    getter object : StripeObject
  end

  getter id : String
  getter api_version : String
  getter data : Data
  getter request : Request
  getter object : String = "event"
  getter account : String?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  getter livemode : Bool?

  getter pending_webhooks : Int32

  getter type : String
end
