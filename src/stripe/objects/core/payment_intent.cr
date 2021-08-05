@[EventPayload]
class Stripe::PaymentIntent
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method

  enum Status
    RequiresPaymentMethod
    RequiresConfirmation
    RequiresAction
    Processing
    Canceled
    Succeeded
  end

  getter id : String
  getter application : String?
  getter cancellation_reason : String?
  getter client_secret : String?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?
  getter customer : String?
  getter client_secret : String?
  getter description : String?
  getter livemode : Bool
  getter last_setup_error : Hash(String, String | PaymentMethods::Card | PaymentMethods::BankAccount)?
  getter metadata : Hash(String, String)?
  getter payment_method_types : Array(String)?
  getter payment_method : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::PaymentIntent::Status))]
  getter status : Status?
  getter usage : String?
end
