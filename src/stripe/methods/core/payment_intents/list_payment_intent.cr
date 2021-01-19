class Stripe::PaymentIntent
  def self.list(
    customer : String? = nil,
    limit : Int32? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  ) : List(Stripe::PaymentIntent)
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(customer limit starting_after ending_before) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.get("/v1/payment_intents", form: io.to_s)

    if response.status_code == 200
      List(Stripe::PaymentIntent).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
