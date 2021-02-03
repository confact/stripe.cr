class Stripe::Refund
  def self.create(
    charge : String | Stripe::Charge? = nil,
    amount : Int32? = nil,
    metadata : Hash? = nil,
    payment_intent : String | Stripe::PaymentIntent? = nil,
    reason : String? = nil
  ) : Refund forall T, U
    charge = charge.not_nil!.id if charge.is_a?(Stripe::Charge)

    payment_intent = payment_intent.not_nil!.id if payment_intent.is_a?(Stripe::PaymentIntent)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(charge amount metadata payment_intent reason) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/refunds", form: io.to_s)

    if response.status_code == 200
      Refund.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
