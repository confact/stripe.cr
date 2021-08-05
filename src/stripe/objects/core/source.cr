@[EventPayload]
class Stripe::Source
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method

  enum Status
    Canceled
    Chargeable
    Consumed
    Failed
    Pending
  end

  class Owner
    include JSON::Serializable

    getter address : Hash(String, String | Nil)?
    getter email : String?
    getter name : String?
    getter phone : String?
  end

  getter id : String

  getter amount : Int32?

  getter currency : String

  getter customer : String?

  getter metadata : Hash(String, String | Nil)?

  getter owner : Owner?

  getter redirect : Hash(String, String)?

  getter statement_descriptor : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Source::Status))]
  getter status : Status

  getter type : String

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  getter client_secret : String

  getter code_verification : Hash(String, String | Int32)?

  getter receiver : Hash(String, String | Int32)?
end
