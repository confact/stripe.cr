class Stripe::Subscription
  def self.delete(id : String)
    response = Stripe.client.delete("/v1/subscriptions/#{id}")

    if response.status_code == 200
      Subscription.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.delete(subscription : Subscription)
    delete(subscription.id)
  end
end
