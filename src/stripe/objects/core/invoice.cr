@[EventPayload]
class Stripe::Invoice
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method
  add_list_method(
    customer : String? = nil,
    status : String? | Stripe::Invoice::Status? = nil,
    limit : Int32? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  )

  enum CollectionMethod
    ChargeAutomatically
    SendInvoice
  end

  enum Status
    Draft
    Open
    Paid
    Uncollectible
    Void
  end

  class LineItem
    include JSON::Serializable

    getter id : String

    getter amount : Int32?

    getter currency : String?

    getter description : String?

    getter discountable : Bool?

    getter invoice_item : String?

    getter livemode : Bool

    getter proration : Bool

    getter metadata : Hash(String, String)?

    getter period : Hash(String, Int32)?

    getter price : Stripe::Price?

    getter subscription : String? | Stripe::Subscription?
    getter subscription_item : String?

    getter type : String?

    @[JSON::Field(converter: Time::EpochConverter)]
    getter created : Time?

    getter quantity : Int32
    getter tax_rates : Array(Stripe::TaxRate)?
  end

  getter id : String
  getter account_country : String?
  getter account_name : String?
  getter amount_due : Int32?
  getter amount_paid : Int32?
  getter amount_remaining : Int32?
  getter application_fee_amount : Int32?
  getter attempt_count : Int32
  getter attempted : Bool
  getter auto_advance : Bool
  getter billing : String?
  getter billing_reason : String?
  getter charge : String?

  getter payment_intent : String? | Stripe::PaymentIntent?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Invoice::CollectionMethod))]
  getter collection_method : CollectionMethod
  getter customer : String?
  getter customer_address : String?
  getter customer_email : String?
  getter customer_name : String?
  getter customer_phone : String?
  getter customer_shipping : Hash(String, String | Hash(String, String))?
  getter customer_tax_exempt : String?

  getter default_tax_rates : Array(Hash(String, String | Bool | Time | Hash(String, String)))?

  getter description : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Invoice::Status))]
  getter status : Status

  getter ending_balance : Int32?

  getter lines : List(LineItem)?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter due_date : Time?
  getter invoice_pdf : String?
  getter hosted_invoice_url : String?

  getter livemode : Bool
end
