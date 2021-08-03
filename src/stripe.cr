require "json"
require "http/client"
require "./ext/**"

class Stripe
  class Unset
  end

  @@api_key : String?
  @@version : String?

  BASE_URL = URI.parse("https://api.stripe.com")

  def self.api_key=(api_key)
    @@api_key = api_key
  end

  def self.api_key
    @@api_key
  end

  def self.version=(version)
    @@version = version
  end

  def self.version
    @@version
  end

  def self.client : HTTP::Client
    return @@client.not_nil! unless @@client.nil?

    self.reset_client

    @@client.not_nil!
  end

  def self.reset_client
    @@client = HTTP::Client.new(BASE_URL)

    if !@@version.nil?
      @@client.not_nil!.before_request do |request|
        request.headers["Authorization"] = "Bearer #{@@api_key}"
        request.headers["Stripe-Version"] = @@version.not_nil!
      end
    else
      @@client.not_nil!.before_request do |request|
        request.headers["Authorization"] = "Bearer #{@@api_key}"
      end
    end
  end
end

annotation EventPayload
end

require "./stripe/**"

# This is needed for Stripe::Event.
# The only way I found to have a Payload complete Union is to call the macro after requiring all the files.

macro event_payload_objects_union
  {% begin %}
    alias Payload = {{"Union(#{Object.all_subclasses.select(&.annotation(EventPayload)).splat})".id}}
{% end %}
end

macro stripe_object_mapping
  {% begin %}
          {
        {% for item in Object.all_subclasses.select(&.annotation(EventPayload)) %}
    {{"#{item.id.gsub(/Stripe::/, "").underscore.gsub(/::/, ".").id}"}} => {{item.id}},
  {% end %}
      }
{% end %}
end

event_payload_objects_union
