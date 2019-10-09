class Stripe
  def retrieve_subscription(id : String)
    response = @client.get("/v1/subscriptions/#{id}")

    if response.status_code == 200
      return Subscription.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def retrieve_subscription(subscription : Subscription)
    retrieve_subscription(subscription.id)
  end
end
