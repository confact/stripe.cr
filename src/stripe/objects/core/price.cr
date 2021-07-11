@[EventPayload]
class Stripe::Price
  include JSON::Serializable

  getter id : String
  getter active : Bool?
  getter currency : String?
  getter metadata : Hash(String, String)?
  getter nickname : String?
  getter product : String? | Stripe::Product?
  getter type : String?
  getter unit_amount : Int32?
  getter billing_scheme : String?
  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time
  getter livemode : Bool
  getter unit_amount_decimal : String?
end
