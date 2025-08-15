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

  enum CustomerCreation
    Always
    IfRequired
  end

  enum Status
    Complete
    Expired
    Open
  end

  enum UIMode
    Hosted
    Embedded
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

  # New fields from API response
  getter adaptive_pricing : Hash(String, Bool)?
  getter after_expiration : Hash(String, JSON::Any)?
  getter automatic_tax : Hash(String, Bool | String?)?
  getter client_secret : String?
  getter collected_information : Hash(String, JSON::Any)?
  getter consent : Hash(String, JSON::Any)?
  getter consent_collection : Hash(String, JSON::Any)?
  getter created : Int64?
  getter currency_conversion : Hash(String, JSON::Any)?
  getter custom_fields : Array(Hash(String, JSON::Any))?
  getter custom_text : Hash(String, String?)?
  
  @[JSON::Field(converter: Enum::StringConverter(Stripe::Checkout::Session::CustomerCreation))]
  getter customer_creation : CustomerCreation?
  getter customer_details : Hash(String, String | Hash(String, String) | Array(String)?)?
  getter discounts : Array(Hash(String, JSON::Any))?
  getter expires_at : Int64?
  getter invoice : String? | Stripe::Invoice?
  getter invoice_creation : Hash(String, JSON::Any)?
  getter locale : String?
  getter origin_context : Hash(String, JSON::Any)?
  getter payment_link : String?
  getter payment_method_collection : String?
  getter payment_method_configuration_details : Hash(String, JSON::Any)?
  getter payment_method_options : Hash(String, Hash(String, String))?
  getter permissions : Hash(String, JSON::Any)?
  getter phone_number_collection : Hash(String, Bool)?
  getter recovered_from : String?
  getter saved_payment_method_options : Hash(String, Array(String) | String?)?
  getter shipping_cost : Hash(String, JSON::Any)?
  getter shipping_options : Array(Hash(String, JSON::Any))?
  
  @[JSON::Field(converter: Enum::StringConverter(Stripe::Checkout::Session::Status))]
  getter status : Status?
  getter total_details : Hash(String, Int32)?
  
  @[JSON::Field(converter: Enum::StringConverter(Stripe::Checkout::Session::UIMode))]
  getter ui_mode : UIMode?
  getter wallet_options : Hash(String, JSON::Any)?

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

  getter url : String?
end