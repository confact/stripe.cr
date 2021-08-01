# https://stripe.com/docs/api/customer_portal

class Stripe::BillingPortal::Session
  include JSON::Serializable

  getter id : String
  getter object : String? = "billing_portal.session"

  getter return_url : String

  getter customer : String? | Stripe::Customer?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  getter livemode : Bool?

  getter url : String?
end
