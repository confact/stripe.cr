class Stripe::Subscription
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/subscriptions/#{id}")

    if response.status_code == 200
      Subscription.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(subscription : Subscription)
    retrieve(subscription.id)
  end
end
