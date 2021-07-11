# https://stripe.com/docs/api/payouts/object
@[EventPayload]
class Stripe::Payout
  include JSON::Serializable

  enum Status
    Paid
    Pending
    InTransit
    Canceled
    Failed
  end

  getter id : String

  getter amount : Int32

  @[JSON::Field(converter: Time::EpochConverter)]
  getter arrival_date : Time

  getter currency : String

  getter description : String?

  getter metadata : Hash(String, String | Nil)?

  getter statement_descriptor : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Payout::Status))]
  getter status : Status

  getter balance_transaction : String?

  getter source_type : String
  getter method : String
  getter destination : String? | Stripe::PaymentMethods::Card? | Stripe::PaymentMethods::BankAccount?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  getter automatic : Bool

  getter livemode : Bool

  getter failure_balance_transaction : String?
  getter failure_code : String?
  getter failure_message : String?
end
