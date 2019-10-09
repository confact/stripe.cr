# https://stripe.com/docs/api/subscriptions/object
struct Stripe::Subscription
  include JSON::Serializable

  struct Item
    include JSON::Serializable

    getter id : String

    getter billing_thresholds : Hash(String, Int32)?

    getter plan : Stripe::Plan?

    @[JSON::Field(converter: Time::EpochConverter)]
    getter created : Time?

    getter quantity : Int32
    getter tax_rates : Array(Stripe::TaxRate)?
  end

  getter id : String
  getter customer : String?
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
  getter created : Time

  @[JSON::Field(converter: Time::EpochConverter)]
  getter current_period_end : Time

  @[JSON::Field(converter: Time::EpochConverter)]
  getter current_period_start : Time

  getter days_until_due : Int32?
  getter default_payment_method : String?
  getter default_source : String?
  getter default_tax_rates : Array(Stripe::TaxRate)?
  getter livemode : Bool
  getter latest_invoice : String?
  getter pending_setup_intent : String?
  getter quantity : Int32
  getter livemode : Bool
  getter schedule : String?

  getter plan : Stripe::Plan?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter start : Time

  @[JSON::Field(converter: Time::EpochConverter)]
  getter start_date : Time

  getter items : List(Item)
end
