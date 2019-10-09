struct Stripe::SetupIntent
  include JSON::Serializable


  getter id : String
  getter application : String?
  getter cancellation_reason : String?
  getter client_secret : String?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time
  getter customer : String?
  getter client_secret : String?
  getter description : String?
  getter livemode : Bool
  getter last_setup_error : Hash(String, String | PaymentMethods::Card | PaymentMethods::BankAccount)?
  getter metadata : Hash(String, String)?
  getter payment_method_types : Array(String)
  getter status : String
  getter usage : String
end
