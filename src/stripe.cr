require "json"
require "http/client"
require "./ext/**"

class Stripe
  class Unset
  end

  @@api_key : String?
  @@version : String?
  @@client : HTTP::Client?

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
    if client = @@client
      client
    else
      reset_client
    end
  end

  def self.reset_client : HTTP::Client
    client = HTTP::Client.new(BASE_URL)

    if version = @@version
      client.before_request do |request|
        request.headers["Authorization"] = "Bearer #{@@api_key}"
        request.headers["Stripe-Version"] = version
      end
    else
      client.before_request do |request|
        request.headers["Authorization"] = "Bearer #{@@api_key}"
      end
    end

    @@client = client
    client
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
