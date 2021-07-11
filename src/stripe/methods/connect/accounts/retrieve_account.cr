class Stripe::Account
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/accounts/#{id}")

    if response.status_code == 200
      Account.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(account : Account)
    retrieve(account.id)
  end
end
