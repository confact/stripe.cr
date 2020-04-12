class Stripe::TaxRate
  def self.retrieve(id : String) : TaxRate
    response = Stripe.client.get("/v1/tax_rates/#{id}")

    if response.status_code == 200
      return TaxRate.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(tax_rate : TaxRate)
    retrieve(tax_rate.id)
  end
end
