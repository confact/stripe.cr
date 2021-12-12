# https://stripe.com/docs/api/coupons/object
@[EventPayload]
class Stripe::Coupon
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method

  getter id : String

  getter amount_off : Int32?
  getter currency : String?
  getter duration : String?
  getter duration_in_months : Int32?
  getter metadata : Hash(String, String | Nil)?
  getter name : String?
  getter percent_off : Float32?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  getter livemode : Bool?
  getter max_redemptions : Int32?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter redeem_by : Time?

  getter times_redeemed : Int32?
  getter valid : Bool?
end
