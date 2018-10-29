struct Stripe::Shipping::Address
  include JSON::Serializable

  getter city : String?
  getter country : String?
  getter line1 : String
  getter line2 : String?
  getter postal_code : String?
  getter state : String?
end
