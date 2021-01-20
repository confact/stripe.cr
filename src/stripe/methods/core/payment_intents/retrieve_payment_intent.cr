class Stripe::PaymentIntent
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/payment_intents/#{id}")

    if response.status_code == 200
      PaymentIntent.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(setup_intent : PaymentIntent)
    retrieve(setup_intent.id)
  end
end
