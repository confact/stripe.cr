class Stripe
  def create_customer(
    account_balance : Int32? = nil,
    coupon : String? = nil,
    default_source : String | Token? = nil,
    description : String | Token? = nil,
    email : String? = nil,
    invoice_prefix : String? = nil,
    payment_method : String? | Token? | Stripe::PaymentMethod? = nil,
    metadata : Hash? = nil,
    shipping : T? = nil,
    source : String | Token | PaymentMethods::Card? = nil,
    tax_info : U? = nil,
    invoice_settings : U? = nil
  ) : Customer forall T, U
    case source
    when Token, PaymentMethods::Card, PaymentMethods::BankAccount
      source = source.not_nil!.id
    end

    case payment_method
    when Token, Stripe::PaymentMethod
      source = source.not_nil!.id
    end

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(account_balance coupon default_source payment_method description email invoice_prefix invoice_settings metadata shipping source tax_info) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = @client.post("/v1/customers", form: io.to_s)

    if response.status_code == 200
      return Customer.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
