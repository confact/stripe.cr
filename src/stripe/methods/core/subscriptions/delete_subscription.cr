class Stripe
  def delete_subscription(id : String)
    response = @client.delete("/v1/subscriptions/#{id}")

    if response.status_code == 200
      return Subscription.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def delete_subscription(subscription : Subscription)
    delete_subscription(subscription.id)
  end
end
