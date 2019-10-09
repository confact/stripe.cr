class Stripe
  def retrieve_setup_intent(id : String)
    response = @client.get("/v1/setup_intents/#{id}")

    if response.status_code == 200
      return SetupIntent.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def retrieve_setup_intent(setup_intent : SetupIntent)
    retrieve_setup_intent(setup_intent.id)
  end
end
