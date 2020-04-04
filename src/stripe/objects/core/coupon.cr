# https://stripe.com/docs/api/coupons/object
struct Stripe::Coupon
  include JSON::Serializable

  getter id : String

  getter amount_off : Int32
  getter currency : String
  getter duration : String
  getter duration_in_months : Int32
  getter metadata : Hash(String, String | Nil)?
  getter percent_off : Float32

  getter times_redeemed : Int32
  getter max_redemptions : Int32?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter redeem_by : Time?
end
