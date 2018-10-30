require "json"
require "http/client"
require "./ext/**"

class Stripe
  BASE_URL = URI.parse("https://api.stripe.com")

  def initialize(api_key : String)
    @client = HTTP::Client.new(BASE_URL)
    @client.before_request do |request|
      request.headers["Authorization"] = "Bearer #{api_key}"
    end
  end
end

require "./stripe/*"
