class Stripe::Customer
  def self.create(
    balance : Int32? = nil,
    coupon : String? = nil,
    default_source : String | Token? = nil,
    name : String | Token? = nil,
    description : String | Token? = nil,
    email : String? = nil,
    phone : String? = nil,
    invoice_prefix : String? = nil,
    payment_method : String? | Token? | Stripe::PaymentMethod? = nil,
    metadata : Hash? = nil,
    shipping : T? = nil,
    source : String | Token | PaymentMethods::Card? = nil,
    tax_info : U? = nil,
    invoice_settings : U? = nil,
    expand : Array(String)? = nil
  ) : Customer forall T, U
    case source
    when Token, PaymentMethods::Card, PaymentMethods::BankAccount
      source = source.not_nil!.id
    when Nil
      source = nil
    end

    case payment_method
    when Token, Stripe::PaymentMethod
      payment_method = payment_method.not_nil!.id
    when Nil
      payment_method = nil
    end

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(balance coupon default_source payment_method name description email phone invoice_prefix invoice_settings metadata shipping source tax_info expand) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/customers", form: io.to_s)

    if response.status_code == 200
      Customer.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
