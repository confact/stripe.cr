# https://stripe.com/docs/api/subscriptions/object
@[EventPayload]
class Stripe::Subscription
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method
  add_list_method(
    customer : String? = nil,
    status : String? | Stripe::Subscription::Status? = nil,
    limit : Int32? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  )
  add_delete_method

  enum Status
    Incomplete
    IncompleteExpired
    Trialing
    Active
    PastDue
    Canceled
    Unpaid
  end

  class Item
    include JSON::Serializable

    getter id : String

    getter billing_thresholds : Hash(String, Int32)?

    getter price : Stripe::Price?

    @[JSON::Field(converter: Time::EpochConverter)]
    getter created : Time?

    getter quantity : Int32
    getter tax_rates : Array(Stripe::TaxRate)?
  end

  getter id : String
  getter customer : String? | Stripe::Customer?
  getter application_fee_percent : Float32?
  getter billing : String?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter billing_cycle_anchor : Time?
  getter billing_thresholds : Hash(String, Int32 | Bool)?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter cancel_at : Time?
  getter cancel_at_period_end : Bool

  @[JSON::Field(converter: Time::EpochConverter)]
  getter canceled_at : Time?
  getter collection_method : String?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter current_period_end : Time

  @[JSON::Field(converter: Time::EpochConverter)]
  getter current_period_start : Time

  getter days_until_due : Int32?
  getter default_payment_method : String? | Stripe::PaymentMethod?
  getter default_source : String?
  getter default_tax_rates : Array(Stripe::TaxRate)?
  getter discount : Stripe::Discount?
  getter livemode : Bool?
  getter latest_invoice : String? | Stripe::Invoice?
  getter pending_setup_intent : String? | Stripe::SetupIntent?
  getter schedule : String?
  getter metadata : Hash(String, String)?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter start : Time?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter start_date : Time?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Subscription::Status))]
  getter status : Status

  getter items : List(Item)?
end
