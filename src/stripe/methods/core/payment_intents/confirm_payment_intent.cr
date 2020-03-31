class Stripe
  def confirm_payment_intent(
    intent : String | PaymentIntent? = nil,
    payment_method : String | Token | PaymentMethods::Card | PaymentMethods::BankAccount? = nil,
    return_url : String? = nil
  ) : PaymentIntent forall T, U
    intent = intent.as(PaymentIntent).id if intent.is_a?(PaymentIntent)

    case payment_method
    when Token, PaymentMethods::Card, PaymentMethods::BankAccount
      payment_method = payment_method.not_nil!.id
    end

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(payment_method return_url) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = @client.post("/v1/payment_intents/#{intent}/confirm", form: io.to_s)

    if response.status_code == 200
      return PaymentIntent.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
