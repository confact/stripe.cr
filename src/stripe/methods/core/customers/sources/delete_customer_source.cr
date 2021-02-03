class Stripe::Customer
  def self.detach_source(
    customer : String,
    source : String
  )
    response = Stripe.client.delete("/v1/customers/#{customer}/sources/#{source}")

    if response.status_code == 200
      Source.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.detach_source(customer : Customer, source : Source)
    delete(customer.id, source.id)
  end
end
