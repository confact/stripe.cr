class Stripe::Event
  include JSON::Serializable

  def self.construct_from(values)
    Event.from_json(values)
  end

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?
  getter id : String?
  getter type : String?
  getter data : String? | Stripe::Checkout::Session? | Stripe::Subscription?
  getter object : String?
  getter amount : Int32?
  getter client_secret : String?
  getter currency : String?
  getter flow : String?
  getter livemode : Bool?
  getter metadata : Hash(String, String)?
end