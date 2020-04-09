class Stripe::PaymentMethods::Card
  include JSON::Serializable

  enum Check
    Pass
    Fail
    Unavailable
    Unchecked
  end

  enum Funding
    Credit
    Debit
    Prepaid
    Unknown
  end

  enum TokenizationMethod
    ApplePay
    AndroidPay
  end

  getter id : String
  getter address_city : String?
  getter address_country : String?
  getter address_line1 : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::PaymentMethods::Card::Check))]
  getter address_line1_check : Check?
  getter address_line2 : String?
  getter address_state : String?
  getter address_zip : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::PaymentMethods::Card::Check))]
  getter address_zip_check : Check?
  getter brand : String
  getter country : String
  getter currency : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::PaymentMethods::Card::Check))]
  getter cvc_check : Check?
  getter dynamic_last4 : String?
  getter exp_month : UInt8?
  getter exp_year : UInt16?
  getter fingerprint : String?

  getter customer : String? | Stripe::Customer?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::PaymentMethods::Card::Funding))]
  getter funding : Funding?
  getter last4 : String?
  getter metadata : Hash(String, String)?
  getter name : String?

  getter object : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::PaymentMethods::Card::TokenizationMethod))]
  getter tokenization_method : TokenizationMethod?
end
