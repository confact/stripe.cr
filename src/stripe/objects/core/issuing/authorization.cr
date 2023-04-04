@[EventPayload]
class Stripe::Issuing::Authorization
  include JSON::Serializable

  getter id : String
  getter object : String = "issuing.authorization"
  getter amount : Int32 = 0
  getter amount_details : Hash(String, String?)
  getter approved : Bool = false
  getter authorization_method : String
  getter balance_transactions : Array(BalanceTransaction)
  getter card : Stripe::Issuing::Card
  getter cardholder : String
end
