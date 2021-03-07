class Stripe::Event
  include JSON::Serializable

  def self.construct_from(values)
    Event.from_json(values)
  end

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  @[JSON::Field(key: "object")]
  getter object_type : String?

  @[JSON::Field(root: "data", key: "object")]
  getter object : Stripe::Checkout::Session? | Stripe::Subscription?

  getter api_version : String?
  getter id : String?
  getter type : String?
  getter livemode : Bool?
  getter pending_webhooks : Int32?
end
