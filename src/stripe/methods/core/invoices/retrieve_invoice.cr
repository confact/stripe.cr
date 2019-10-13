class Stripe
  def retrieve_invoice(id : String)
    response = @client.get("/v1/invoices/#{id}")

    if response.status_code == 200
      return Invoice.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def retrieve_invoice(invoice : Invoice)
    retrieve_invoice(invoice.id)
  end
end
