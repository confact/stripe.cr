class Stripe
  def retrieve_payment_method(id : String)
    response = @client.get("/v1/payment_methods/#{id}")

    if response.status_code == 200
      return PaymentMethod.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def retrieve_payment_method(payment_method : PaymentMethod)
    retrieve_payment_method(payment_method.id)
  end
end
