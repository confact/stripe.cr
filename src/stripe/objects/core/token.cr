# https://stripe.com/docs/api/tokens/object
class Stripe::Token
  include JSON::Serializable

  enum Type
    Account
    BankAccount
    Card
    Pii
  end

  getter id : String
  getter bank_account : PaymentMethods::BankAccount?
  getter card : PaymentMethods::Card?
  getter client_ip : String?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time
  getter livemode : Bool

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Token::Type))]
  getter type : Type
  getter used : Bool
end
