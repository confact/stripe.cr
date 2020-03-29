struct Stripe::PaymentMethod
  include JSON::Serializable


  getter id : String
  getter created : Time
  getter customer : String?
  getter description : String?
  getter type : String?
  getter livemode : Bool

  getter billing_details : Stripe::Shipping::Address

  getter card : Stripe::PaymentMethods::Card
end
