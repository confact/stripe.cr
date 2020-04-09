class Stripe::TaxRate
  include JSON::Serializable

  getter id : String
  getter object : String?
  getter inclusive : Bool
  getter object : String?
  getter customer : String?
  getter active : Bool
  getter created : Time
  getter description : String?
  getter jurisdiction : String?
  getter metadata : Hash(String, String)?
  getter percentage : Float32?
end
