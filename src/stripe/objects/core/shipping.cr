class Stripe::Shipping
  include JSON::Serializable

  getter address : Stripe::Address
  getter carrier : String?
  getter name : String
  getter phone : String?
  getter tracking_number : String?
end
