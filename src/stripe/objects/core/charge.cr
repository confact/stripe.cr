# https://stripe.com/docs/api/charges/object
@[EventPayload]
class Stripe::Charge
  include JSON::Serializable

  class FraudDetails
    include JSON::Serializable

    enum UserReport
      Safe
      Fraudulent
    end

    enum StripeReport
      Fraudulent
    end

    @[JSON::Field(converter: Enum::StringConverter(Stripe::Charge::FraudDetails::UserReport))]
    getter user_report : UserReport?

    @[JSON::Field(converter: Enum::StringConverter(Stripe::Charge::FraudDetails::StripeReport))]
    getter user_report : StripeReport?
  end

  class Outcome
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
  getter amount_captured : Int32?
  getter amount_refunded : Int32
  getter application : String?
  getter application_fee : String?
  getter application_fee_amount : Int32?
  getter balance_transaction : String? # | Stripe::BalanceTransaction

  class BillingDetails
    include JSON::Serializable

    getter address : Stripe::Address?
    getter email : String?
    getter name : String?
    getter phone : String?
  end

  getter billing_details : BillingDetails?

  getter captured : Bool?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time

  getter currency : String
  getter customer : String? | Stripe::Customer?
  getter description : String?
  getter destination : String?
  getter dispute : String?
  getter failure_code : String?
  getter failure_message : String?
  getter fraud_details : FraudDetails?
  getter invoice : String? | Stripe::Invoice?
  getter livemode : Bool
  getter metadata : Hash(String, String)?
  getter on_behalf_of : String? | Stripe::Account?
  getter order : String? # | Stripe::Order
  getter outcome : Outcome?
  getter paid : Bool?
  getter payment_intent : String?
  getter receipt_email : String?
  getter receipt_url : String?
  getter receipt_number : String?
  getter refunded : Bool
  getter refunds : List(Refund)
  getter review : String?
  getter shipping : Shipping?
  getter source : PaymentMethods::Card
  getter source_transfer : String? | Stripe::Account?
  getter statement_descriptor : String?
  getter statement_descriptor_suffix : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Charge::Status))]
  getter status : Status

  getter transfer : String? | Stripe::Account?

  class TransferData
    include JSON::Serializable
    getter amount : Int32?
    getter destination : String? | Stripe::Account?
  end

  getter transfer_data : TransferData?
  getter transfer_group : String?
end
