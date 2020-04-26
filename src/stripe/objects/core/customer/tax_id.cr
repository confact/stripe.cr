class Stripe::Customer::TaxID
  include JSON::Serializable

  getter id : String
  getter country : String

  getter customer : String | Stripe::Customer

  getter type : String
  getter value : String

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time

  getter verification : Hash(String, String | Nil)
end
