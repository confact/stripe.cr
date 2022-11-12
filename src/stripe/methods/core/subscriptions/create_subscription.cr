class Stripe::Subscription
  def self.create(
    customer : String | Customer? = nil,
    coupon : String? = nil,
    default_source : String | Token? = nil,
    default_payment_method : String | Token? = nil,
    off_session : Bool? = nil,
    metadata : Hash? = nil,
    items : U? = nil,
    add_invoice_items : U? = nil,
    trial_end : Time? = nil,
    expand : Array(String)? = nil
  ) : Subscription forall T, U
    customer = customer.not_nil!.id if customer.is_a?(Customer)

    default_source = default_source.not_nil!.id if default_source.is_a?(Token)
    default_payment_method = default_payment_method.not_nil!.id if default_payment_method.is_a?(Token)

    trial_end = trial_end.to_unix unless trial_end.nil?

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(customer coupon default_source off_session metadata default_payment_method items add_invoice_items expand trial_end) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/subscriptions", form: io.to_s)

    if response.status_code == 200
      Subscription.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
