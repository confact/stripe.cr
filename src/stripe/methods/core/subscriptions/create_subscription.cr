class Stripe
  def create_subscription(
    customer : String | Customer? = nil,
    coupon : String? = nil,
    default_source : String | Token? = nil,
    default_payment_method : String | Token? = nil,
    off_session : Bool? = nil,
    metadata : Hash? = nil,
    items : U? = nil
  ) : Subscription forall T, U
    case default_source
    when Token
      default_source = default_source.id
    end

    customer = customer.as(Customer).id if customer.is_a?(Customer)

    case default_payment_method
    when Token, PaymentMethods::Card
      default_payment_method = default_payment_method.not_nil!.id
    end

    validate items, {{U}} do
      type id : String,
      type quantity : Int32,
      type plan : String
    end

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(customer coupon default_source off_session metadata default_payment_method items) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = @client.post("/v1/subscription", form: io.to_s)

    if response.status_code == 200
      return Subscription.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
