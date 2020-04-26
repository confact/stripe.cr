class Stripe::SetupIntent
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/setup_intents/#{id}")

    if response.status_code == 200
      return SetupIntent.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(setup_intent : SetupIntent)
    retrieve(setup_intent.id)
  end
end
