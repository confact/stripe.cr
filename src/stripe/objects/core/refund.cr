@[EventPayload]
class Stripe::Refund
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method

  enum FailureReason
    LostOrStolenCard
    ExpiredOrCanceledCard
    Unknown
  end

  enum Reason
    Duplicate
    Fraudulent
    RequestedByCustomer
  end

  enum Status
    Succeeded
    Failed
    Pending
    Canceled
  end

  getter id : String
  getter amount : Int32
  getter balance_transaction : String?
  getter charge : String

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time

  getter currency : String
  getter failure_balance_transaction : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Refund::FailureReason))]
  getter failure_reason : FailureReason?

  getter metadata : Hash(String, String)?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Refund::Reason))]
  getter reason : Reason?

  getter receipt_number : String?
  getter source_transfer_reversal : String?

  getter payment_intent : String? | Stripe::PaymentIntent?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Refund::Status))]
  getter status : Status
end
