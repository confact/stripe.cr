class Stripe
  def retrieve_customer(id : String)
    response = @client.get("/v1/customers/#{id}")

    if response.status_code == 200
      return Customer.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def retrieve_customer(customer : Customer)
    retrieve_customer(customer.id)
  end
end
