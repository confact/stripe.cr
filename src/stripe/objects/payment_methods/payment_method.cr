struct Stripe::PaymentMethod
  include JSON::Serializable

  struct BillingDetails
    include JSON::Serializable
    
    getter address : Stripe::Shipping::Address?
    getter email : String?
    getter name : String?
    getter phone : String?
  end

  getter id : String
  getter created : Time
  getter customer : String?
  getter description : String?
  getter type : String?
  getter livemode : Bool


  getter billing_details : BillingDetails?

  getter card : Stripe::PaymentMethods::Card
end