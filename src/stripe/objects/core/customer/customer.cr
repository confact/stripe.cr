# https://stripe.com/docs/api/customers/object
struct Stripe::Customer
  include JSON::Serializable

  struct TaxInfo
    include JSON::Serializable

    enum Type
      Vat
    end

    getter tax_id : String
    getter type : Type
  end

  struct TaxInfoVerification
    include JSON::Serializable

    enum Status
      Unverified
      Pending
      Verified
    end

    @[JSON::Field(converter: Enum::StringConverter(Stripe::Customer::TaxInfoVerification::Status))]
    getter status : Status
    getter verified_name : String?
  end

  getter id : String
  getter account_balance : Int32?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time
  getter currency : String?
  getter default_source : String?
  getter delinquent : Bool
  getter description : String?
  getter email : String?
  getter invoice_prefix : String?
  getter livemode : Bool
  getter metadata : Hash(String, String)
  getter shipping : Shipping?
  getter sources : List(PaymentMethods::Card | PaymentMethods::BankAccount)?
  # getter subscriptions : List?
  getter tax_info : TaxInfo?
  getter tax_info_verification : TaxInfoVerification?
end
