# https://stripe.com/docs/api/events/object

class Stripe::Event
  include JSON::Serializable

  class Request
    include JSON::Serializable
    getter id : String?
    getter idempotency_key : String?
  end

  class Data
    include JSON::Serializable

    @[JSON::Field(converter: Stripe::EventPayloadObjectConverter)]
    getter object : Payload

    getter previous_attributes : JSON::Any?
  end

  getter id : String
  getter api_version : String
  getter data : Data
  getter request : Request?
  getter object : String = "event"
  getter account : String?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  getter livemode : Bool?

  getter pending_webhooks : Int32

  getter type : String
end

module Stripe::EventPayloadObjectConverter
  def self.from_json(value : JSON::PullParser)
    object_json = value.read_raw
    object_identifier = JSON.parse(object_json)["object"].to_s
    stripe_object_mapping[object_identifier].from_json(object_json)
  rescue
    puts value.read_raw
  end
end
