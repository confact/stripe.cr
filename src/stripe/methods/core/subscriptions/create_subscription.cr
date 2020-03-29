class Stripe
  def create_subscription(
    customer : String | Customer? = nil,
    coupon : String? = nil,
    plan : String? = nil,
    default_source : String | Token? = nil,
    default_payment_method : String | Token? = nil,
    off_session : Bool? = nil,
    metadata : Hash? = nil,
    items : U? = nil
  ) : Subscription forall T, U

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(customer coupon plan default_source off_session metadata default_payment_method items) %}
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
