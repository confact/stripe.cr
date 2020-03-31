class Stripe
  def retrieve_payment_intent(id : String)
    response = @client.get("/v1/payment_intents/#{id}")

    if response.status_code == 200
      return PaymentIntent.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def retrieve_payment_intent(setup_intent : PaymentIntent)
    retrieve_payment_intent(setup_intent.id)
  end
end
