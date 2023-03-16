class Stripe::Topup
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method
  add_cancel_method
  add_list_method(
    status : String? = nil,
    amount : Hash(String, Int32)? = nil,
    created : Hash(String, Int32)? = nil,
    limit : Int32? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  )
  add_create_method(
    amount : Int32,
    currency : String,
    description : String? = nil,
    metadata : Hash | NamedTuple? = nil,
    source : Hash(String, Bool | Int32 | String | Hash(String, String? | Hash(String, String?) | Int32) | Nil)? = nil,
    statement_descriptor : String? = nil,
    transfer_group : String? = nil
  )

  add_update_method(
    description : String? = nil,
    metadata : Hash | NamedTuple? = nil,
  )

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
