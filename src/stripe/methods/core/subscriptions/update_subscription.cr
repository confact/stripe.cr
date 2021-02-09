class Stripe::Subscription
  def self.update(
    subscription : String | Subscription,
    cancel_at_period_end : Bool | Unset = Unset.new,
    customer : String | Customer? | Unset = Unset.new,
    coupon : String? | Unset = Unset.new,
    default_source : String | Token? | Unset = Unset.new,
    default_payment_method : String | Token? | Unset = Unset.new,
    metadata : Hash? | Unset = Unset.new,
    items : U? | Unset = Unset.new,
    add_invoice_items : U? | Unset = Unset.new
  ) : Subscription forall T, U
    default_source = default_source.as(Token).id if default_source.is_a?(Token)

    default_payment_method = default_payment_method.as(Token).id if default_payment_method.is_a?(Token)

    customer = customer.as(Customer).id if customer.is_a?(Customer)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(customer coupon default_source cancel_at_period_end metadata default_payment_method items add_invoice_items) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.is_a?(Unset)
    {% end %}

    case subscription
    when String       then sub_id = subscription
    when Subscription then sub_id = subscription.id
    end

    response = Stripe.client.post("/v1/subscriptions/#{sub_id}", form: io.to_s)

    if response.status_code == 200
      Subscription.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
