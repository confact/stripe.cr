@[EventPayload]
class Stripe::Plan
  include JSON::Serializable

  getter id : String
  getter active : Bool?
  getter aggregate_usage : String?
  getter amount : Int32?
  getter amount_decimal : String?

  getter billing_scheme : String?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time
  getter currency : String?
  getter interval : String?
  getter interval_count : Int32?
  getter livemode : Bool
  getter metadata : Hash(String, String)?
  getter product : String? | Stripe::Product?
  getter tiers : Hash(String, String | Int32)?
  getter tiers_mode : String?
  getter trial_period_days : Int32?
  getter usage_type : String?
end
