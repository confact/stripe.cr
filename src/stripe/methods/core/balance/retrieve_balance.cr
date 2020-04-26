class Stripe::Balance
  def self.retrieve
    response = Stripe.client.get("/v1/balance")

    if response.status_code == 200
      Balance.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
