struct Stripe::Customer
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/customers/#{id}")

    if response.status_code == 200
      return Customer.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(customer : Customer)
    retrieve(customer.id)
  end
end
