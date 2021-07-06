# https://stripe.com/docs/api/discounts/object
@[EventPayload]
class Stripe::Discount
  include JSON::Serializable

  getter id : String

  getter coupon : Stripe::Coupon?
  getter customer : String? | Stripe::Customer?

  # gotta rename these since `end` is not cool as a property name in Crystal
  @[JSON::Field(converter: Time::EpochConverter, key: "end")]
  getter end_date : Time?
  @[JSON::Field(converter: Time::EpochConverter, key: "start")]
  getter start_date : Time?

  getter subscription : String?
  getter checkout_session : String?
  getter invoice : String?
  getter invoice_item : String?

  getter promotion_code : String? | Stripe::PromotionCode?
end
