class Stripe::Event
  include JSON::Serializable

  def self.construct_from(values)
    Event.from_json(values)
  end

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?
  getter object : String?
  getter data : Stripe::Event::Data?
  getter api_version : String?
  getter id : String?
  getter type : String?
  getter livemode : Bool?
  getter pending_webhooks : Int32?
end

class Stripe::Event::Data
  include JSON::Serializable
  getter object : Stripe::Checkout::Session? | Stripe::Subscription?
end
