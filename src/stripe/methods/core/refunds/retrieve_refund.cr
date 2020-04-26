class Stripe::Refund
  def self.retrieve(id : String) : Refund
    response = Stripe.client.get("/v1/refunds/#{id}")

    if response.status_code == 200
      return Refund.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(refund : Refund)
    retrieve(refund.id)
  end
end
