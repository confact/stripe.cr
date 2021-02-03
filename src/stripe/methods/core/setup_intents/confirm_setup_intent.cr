class Stripe::SetupIntent
  def self.confirm(
    intent : String | SetupIntent? = nil,
    payment_method : String | Token | PaymentMethods::Card | PaymentMethods::BankAccount? = nil,
    return_url : String? = nil
  ) : SetupIntent forall T, U
    intent = intent.as(SetupIntent).id if intent.is_a?(SetupIntent)

    if payment_method.is_a?(Token | PaymentMethods::Card | PaymentMethods::BankAccount)
      payment_method = payment_method.not_nil!.id
    end

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(payment_method return_url) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/setup_intents/#{intent}/confirm", form: io.to_s)

    if response.status_code == 200
      SetupIntent.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
