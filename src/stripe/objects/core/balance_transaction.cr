@[EventPayload]
class BalanceTransaction
  include JSON::Serializable
  getter id : String
  getter object : String = "balance_transaction"
  getter amount : Int32

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter available_on : Time?

  getter currency : String
  getter description : String
  getter fee : Int32
  getter fee_details : Array(Hash(String, String))
  getter net : Int32
  getter reporting_category : String
  getter source : String
  getter status : String
  getter type : String
end
