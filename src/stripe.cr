require "json"
require "http/client"
require "./ext/**"

class Stripe
  struct Unset
  end

  BASE_URL = URI.parse("https://api.stripe.com")

  def initialize(api_key : String)
    @client = HTTP::Client.new(BASE_URL)
    @client.before_request do |request|
      request.headers["Authorization"] = "Bearer #{api_key}"
    end
  end

  def initialize(api_key : String, api_version : String)
    @client = HTTP::Client.new(BASE_URL)
    @client.before_request do |request|
      request.headers["Authorization"] = "Bearer #{api_key}"
      request.headers["Stripe-Version"] = api_version
    end
  end
end

require "./stripe/*"
