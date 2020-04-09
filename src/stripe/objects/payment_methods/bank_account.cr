class Stripe::PaymentMethods::BankAccount
  include JSON::Serializable

  enum AccountHolderType
    Individual
    Company
  end

  enum Status
    New
    Validated
    Verified
    Verification_failed
    Errored
  end

  getter id : String?
  getter account_holder_name : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::PaymentMethods::BankAccount::AccountHolderType))]
  getter account_holder_type : AccountHolderType?
  getter bank_name : String?
  getter country : String?
  getter currency : String?
  getter fingerprint : String?
  getter last4 : String?
  getter routing_number : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::PaymentMethods::BankAccount::Status))]
  getter status : Status?
end
