@[EventPayload]
class Stripe::TaxRate
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method

  getter id : String
  getter inclusive : Bool
  getter object : String?
  getter customer : String?
  getter active : Bool

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time
  getter description : String?
  getter jurisdiction : String?
  getter metadata : Hash(String, String)?
  getter percentage : Float32?
end
