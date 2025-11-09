# https://stripe.com/docs/api/transfers/object
@[EventPayload]
class Stripe::Transfer
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method

  getter id : String
  getter amount : Int32
  getter amount_reversed : Int32
  getter balance_transaction : String?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  getter currency : String?
  getter description : String?
  getter destination : String?
  getter destination_payment : String?
  getter? livemode : Bool
  getter metadata : Hash(String, String)?
  getter? reversed : Bool
  getter source_transaction : String?
  getter source_type : String?
  getter transfer_group : String?
end
