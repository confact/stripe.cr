# https://stripe.com/docs/api/checkout/sessions/retrieve
class Stripe::Checkout::Session
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/checkout/sessions/#{id}")

    if response.status_code == 200
      return Stripe::Checkout::Session.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(session : Session)
    retrieve(session.id)
  end
end
