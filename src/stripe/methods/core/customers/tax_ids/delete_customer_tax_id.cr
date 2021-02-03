class Stripe::Customer
  def self.delete_tax_id(id : String, tax_id : String)
    response = Stripe.client.delete("/v1/customers/#{id}/tax_ids/#{tax_id}")

    if response.status_code == 200
      Nil
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.delete_tax_id(customer : Customer, tax_id : Customer::TaxID)
    delete_tax_id(customer.id, tax_id.id)
  end
end
