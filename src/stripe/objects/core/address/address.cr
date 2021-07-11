class Stripe::Address
  include JSON::Serializable

  getter city : String?
  getter country : String? # https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
  getter line1 : String?
  getter line2 : String?
  getter postal_code : String?
  getter state : String?
  getter town : String?
end
