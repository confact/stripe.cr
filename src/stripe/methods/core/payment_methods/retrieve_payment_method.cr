class Stripe::PaymentMethod
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/payment_methods/#{id}")

    if response.status_code == 200
      return PaymentMethod.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(payment_method : PaymentMethod)
    retrieve(payment_method.id)
  end
end
