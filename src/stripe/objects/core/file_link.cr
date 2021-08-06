# https://stripe.com/docs/api/file_links/object

class Stripe::FileLink
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method

  getter id : String
  getter type : String?

  getter object : String = "file_link"
  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time
  @[JSON::Field(converter: Time::EpochConverter)]
  getter expires_at : Time?
  getter expired : Bool?
  getter file : String? | Stripe::File?
  getter metadata : JSON::Any?
  getter url : String?
  getter livemode : Bool?
end
