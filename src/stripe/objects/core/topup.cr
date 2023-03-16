class Stripe::Topup
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method
  getter id : String
  getter object = "topup"
  getter amount : Int32
  getter currency : String
  getter description : String
  getter metadata : Hash(String, String)
  getter status : String
  getter balance_transaction : String?
  getter expected_availability_date : Int32
  getter failure_code : String?
  getter failure_message : String?
  getter? livemode : Bool
  getter source : Hash(String, Bool | Int32 | String | Hash(String, String? | Hash(String, String?) | Int32) | Nil)?
  getter statement_descriptor : String?
  getter transfer_group : String?
  getter metadata : Hash(String, String)
end
