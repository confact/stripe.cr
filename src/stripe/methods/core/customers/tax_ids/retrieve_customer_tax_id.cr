class Stripe::Customer
  def self.retrieve_tax_id(
    id : String,
    tax_id : String
  )
    response = Stripe.client.get("/v1/customers/#{id}/tax_ids/#{tax_id}")

    if response.status_code == 200
      Customer::TaxID.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve_tax_id(customer : Customer, tax_id : Customer::TaxID)
    retrieve_tax_id(customer.id, tax_id.id)
  end
end
