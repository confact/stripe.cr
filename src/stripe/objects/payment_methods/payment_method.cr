class Stripe::PaymentMethod
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method

  class BillingDetails
    include JSON::Serializable

    getter address : Stripe::Address?
    getter email : String?
    getter name : String?
    getter phone : String?
  end

  getter id : String

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time
  getter customer : String? | Stripe::Customer?
  getter description : String?
  getter type : String?
  getter livemode : Bool

  getter billing_details : BillingDetails?
end
