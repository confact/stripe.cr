struct Stripe::Customer
  def self.delete(id : String)
    response = Stripe.client.delete("/v1/customers/#{id}")

    if response.status_code == 200
      return Nil
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.delete(customer : Customer)
    delete(customer.id)
  end
end
