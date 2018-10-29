# https://stripe.com/docs/api/charges/object
struct Stripe::Charge
  include JSON::Serializable

  struct FraudDetails
    include JSON::Serializable

    enum UserReport
      Safe
      Fraudlent
    end

    enum StripeReport
      Fraudlent
    end

    @[JSON::Field(converter: Enum::StringConverter(Stripe::Charge::FraudDetails::UserReport))]
    getter user_report : UserReport?

    @[JSON::Field(converter: Enum::StringConverter(Stripe::Charge::FraudDetails::StripeReport))]
    getter user_report : StripeReport?
  end

  struct Outcome
    include JSON::Serializable

    enum NetworkStatus
      ApprovedByNetwork
      DeclinedByNetwork
      NotSentToNetwork
      ReversedAfterApproval
    end

    enum Reason
      HighestRiskLevel
      ElevatedRiskLevel
      Rule
    end

    enum RiskLevel
      Normal
      Elevated
      Highest
      NotAssessed
      Unknown
    end

    enum Type
      Authorized
      ManualReview
      IssuerDeclined
      Blocked
      Invalid
    end

    @[JSON::Field(converter: Enum::StringConverter(Stripe::Charge::Outcome::NetworkStatus))]
    getter network_status : NetworkStatus

    @[JSON::Field(converter: Enum::StringConverter(Stripe::Charge::Outcome::Reason))]
    getter reason : Reason?

    @[JSON::Field(converter: Enum::StringConverter(Stripe::Charge::Outcome::RiskLevel))]
    getter risk_level : RiskLevel?

    getter risk_score : Int32?
    getter rule : String?
    getter seller_message : String

    @[JSON::Field(converter: Enum::StringConverter(Stripe::Charge::Outcome::Type))]
    getter type : Type
  end

  enum Status
    Succeeded
    Pending
    Failed
  end

  getter id : String
  getter amount : Int32
  getter amount_refunded : Int32
  getter application : String?
  getter application_fee : String?
  getter balance_transaction : String?
  getter captured : Bool?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time

  getter currency : String
  getter customer : String?
  getter description : String?
  getter destination : String?
  getter dispute : String?
  getter failure_code : String?
  getter failure_message : String?
  getter fraud_details : FraudDetails?
  getter invoice : String?
  getter livemode : Bool
  getter metadata : Hash(String, String)?
  getter on_behalf_of : String?
  getter order : String?
  getter outcome : Outcome
  getter paid : Bool
  getter payment_intent : String?
  getter receipt_email : String?
  getter receipt_number : String?
  getter refunded : Bool
  getter refunds : List(Refund)
  getter review : String?
  getter shipping : Shipping?
  getter source : PaymentMethods::Card
  getter source_transfer : String?
  getter statement_descriptor : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Charge::Status))]
  getter status : Status

  getter transfer : String?
  getter transfer_group : String?
end
