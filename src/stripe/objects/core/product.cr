struct Stripe::Product
  include JSON::Serializable

  getter id : String

  getter name : String
  getter active : Bool
  getter description : String?
  getter metadata : Hash(String, String)?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time

  @[JSON::Field(converter: Time::EpochConverter)]
  getter updated : Time

  getter livemode : Bool
  getter statement_descriptor : String
  getter type : String
  getter unit_label : String

end
