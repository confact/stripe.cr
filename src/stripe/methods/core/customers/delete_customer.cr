class Stripe
  def delete_customer(id : String)
    response = @client.delete("/v1/customers/#{id}")

    if response.status_code == 200
      return Nil
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def delete_customer(customer : Customer)
    delete_customer(customer.id)
  end
end
