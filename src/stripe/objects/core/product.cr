@[EventPayload]
class Stripe::Product
  include JSON::Serializable
  include StripeMethods

  add_list_method(
    active : Bool? = nil,
    created : Hash(String, Int32)? = nil,
    ids : Array(String)? = nil,
    shippable : Bool? = nil,
    url : String? = nil,
    limit : Int32? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  )

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
  getter statement_descriptor : String?
  getter type : String
  getter unit_label : String?
end
