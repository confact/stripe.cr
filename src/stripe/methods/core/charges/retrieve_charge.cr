class Stripe::Charge
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/charges/#{id}")

    if response.status_code == 200
      return Charge.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(charge : Charge)
    retrieve(charge.id)
  end
end
