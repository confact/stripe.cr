# https://stripe.com/docs/api/promotion_codes/object
@[EventPayload]
class Stripe::PromotionCode
  include JSON::Serializable

  getter id : String

  getter code : String
  getter coupon : Stripe::Coupon?
  getter metadata : Hash(String, String | Nil)?
  getter active : Bool

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  getter customer : String? | Stripe::Customer?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter expires_at : Time?

  getter livemode : Bool?
  getter max_redemptions : Int32?
  getter times_redeemed : Int32?
end
