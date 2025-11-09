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

  enum Status
    Open
    Complete
    Expired
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

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Checkout::Session::Status))]
  getter status : Status?

  # Newer fields
  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  getter url : String?

  getter phone_number_collection : Hash(String, Bool)?
  getter tax_id_collection : Hash(String, Bool)?
  getter automatic_tax : Hash(String, String | Bool | Nil)?

  getter payment_method_options : Hash(String, String | Bool | Int32 | Hash(String, String | Bool | Int32))?
  getter payment_method_collection : String?
  getter payment_method_configuration : String?
  getter total_details : Hash(String, Int32)?

  getter ui_mode : String?
  getter return_url : String?
  getter payment_link : String?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter expires_at : Time?

  getter invoice_creation : Hash(String, String | Bool | Hash(String, String | Bool))?
  getter invoice : String? | Stripe::Invoice?
  getter recovered_from : String?
  getter customer_creation : String?
  getter customer_details : Hash(String, Bool | String | Hash(String, String | Bool | Array(Hash(String, String))) | Array(Hash(String, String)) | Nil)?
  getter consent : Hash(String, String | Bool | Nil)?
  getter consent_collection : Hash(String, String | Bool | Nil)?
  getter custom_fields : Array(Hash(String, String | Bool | Hash(String, String | Bool) | Array(Hash(String, String | Bool))) )?
  getter custom_text : Hash(String, String | Hash(String, String | Nil) | Nil)?
  getter adaptive_pricing : Hash(String, String | Bool | Nil)?
  getter shipping_cost : Hash(String, String | Int32 | Bool | Hash(String, String | Int32 | Bool))?
  getter shipping_details : Hash(String, String | Hash(String, String | Hash(String, String)) | Nil)?
  getter shipping_options : Array(Hash(String, String | Int32 | Bool | Hash(String, String | Int32 | Bool)))?

  getter subscription : String? | Stripe::Subscription?
end
