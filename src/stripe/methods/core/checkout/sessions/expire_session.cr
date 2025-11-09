class Stripe::Checkout::Session
  def self.expire(
    id : String | Stripe::Checkout::Session,
    expand : Array(String)? = nil
  ) : Stripe::Checkout::Session
    session_id = id.is_a?(Stripe::Checkout::Session) ? id.id : id

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)
    builder.add("expand", expand) unless expand.nil?

    response = Stripe.client.post("/v1/checkout/sessions/#{session_id}/expire", form: io.to_s)

    if response.status_code == 200
      Stripe::Checkout::Session.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end


