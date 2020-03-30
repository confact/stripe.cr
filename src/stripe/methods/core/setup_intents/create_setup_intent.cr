class Stripe
  def create_setup_intent(
    customer : String | Customer? = nil,
    description : String? = nil,
    metadata : Hash(String, String)? = nil,
    on_behalf_of : String? = nil,
    usage : String? = nil,
    payment_method : String | Token | PaymentMethods::Card | PaymentMethods::BankAccount? = nil,
    return_url : String? = nil
  ) : SetupIntent forall T, U
    customer = customer.as(Customer).id if customer.is_a?(Customer)

    case payment_method
    when Token, PaymentMethods::Card, PaymentMethods::BankAccount
      payment_method = payment_method.not_nil!.id
    end

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(customer description metadata usage on_behalf_of payment_method return_url) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = @client.post("/v1/setup_intents", form: io.to_s)

    if response.status_code == 200
      return SetupIntent.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
