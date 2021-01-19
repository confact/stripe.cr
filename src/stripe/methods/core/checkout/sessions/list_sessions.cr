# https://stripe.com/docs/api/checkout/sessions/list
class Stripe::Checkout::Session
  def self.list(
    payment_intent : String? | Stripe::PaymentIntent? = nil,
    subscription : String? | Stripe::Subscription? = nil,
    limit : Int32? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  ) : List(Stripe::Checkout::Session)
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(payment_intent subscription limit starting_after ending_before) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.get("/v1/checkout/sessions", form: io.to_s)

    if response.status_code == 200
      List(Stripe::Checkout::Session).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
