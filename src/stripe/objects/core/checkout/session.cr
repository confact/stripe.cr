# https://stripe.com/docs/api/checkout/sessions/object

@[EventPayload]
class Stripe::Checkout::Session
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method
  add_list_method(
    payment_intent : String? | Stripe::PaymentIntent? = nil,
    subscription : String? | Stripe::Subscription? = nil,
    limit : Int32? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  )

  enum Mode
    Payment
    Setup
    Subscription
  end

  enum PaymentStatus
    Paid
    Unpaid
    NoPaymentRequired
  end

  enum BillingAddressCollection
    Auto
    Required
  end

  enum SubmitType
    Auto
    Pay
    Book
    Donate
  end

  getter id : String
  getter object : String? = "checkout.session"

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Checkout::Session::Mode))]
  getter mode : String | Mode
  getter payment_method_types : Array(String)

  getter cancel_url : String
  getter success_url : String

  getter client_reference_id : String?
  getter customer : String? | Stripe::Customer?
  getter customer_email : String?

  getter line_items : Array(Hash(String, String | Int32))?

  getter metadata : Hash(String, String)?
  getter payment_intent_data : Hash(String, String)?

  getter payment_intent : String? | Stripe::PaymentIntent?
  @[JSON::Field(converter: Enum::StringConverter(Stripe::Checkout::Session::PaymentStatus))]
  getter payment_status : PaymentStatus

  getter subscription : String? | Stripe::Subscription?

  getter allow_promotion_codes : Bool?

  getter amount_subtotal : Int32?
  getter amount_total : Int32?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Checkout::Session::BillingAddressCollection))]
  getter billing_address_collection : BillingAddressCollection?

  getter currency : String?

  getter livemode : Bool?

  getter setup_intent : String? | Stripe::SetupIntent?

  getter shipping : Hash(String, String | Hash(String, String))?

  getter shipping_address_collection : Hash(String, Array(String))?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Checkout::Session::SubmitType))]
  getter submit_type : SubmitType?

  getter subscription : String? | Stripe::Subscription?
end
