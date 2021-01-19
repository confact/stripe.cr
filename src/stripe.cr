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

require "./stripe/**"
