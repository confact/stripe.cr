struct Stripe::Invoice
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/invoices/#{id}")

    if response.status_code == 200
      return Invoice.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(invoice : Invoice)
    retrieve(invoice.id)
  end
end
