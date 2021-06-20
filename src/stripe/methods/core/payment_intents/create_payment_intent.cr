class Stripe::PaymentIntent
  def self.create(
    amount : Int32,
    currency : String,
    confirm : Bool? = nil,
    customer : String | Stripe::Customer? = nil,
    description : String? = nil,
    metadata : Hash(String, String)? = nil,
    on_behalf_of : String? = nil,
    usage : String? = nil,
    payment_method : String | Token | PaymentMethods::Card | PaymentMethods::BankAccount? = nil,
    return_url : String? = nil,
    payment_method_types : Array(String)? = nil,
    receipt_email : String? = nil,
    setup_future_usage : String? = nil,
    transfer_group : String? = nil,
    capture_method : String? = nil,
    expand : Array(String)? = nil
  ) : PaymentIntent forall T, U
    customer = customer.as(Customer).id if customer.is_a?(Customer)

    case payment_method
    when String
      payment_method
    when Token, PaymentMethods::Card, PaymentMethods::BankAccount
      payment_method = payment_method.not_nil!.id
    when Nil
      payment_method = nil
    end

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(amount confirm currency customer description metadata usage on_behalf_of payment_method_types payment_method receipt_email setup_future_usage return_url transfer_group capture_method expand) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/payment_intents", form: io.to_s)

    if response.status_code == 200
      PaymentIntent.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
