# https://stripe.com/docs/api/account_links/object

@[EventPayload]
class Stripe::AccountLink
  include JSON::Serializable
  include StripeMethods

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter expires_at : Time?

  getter url : String?
end
