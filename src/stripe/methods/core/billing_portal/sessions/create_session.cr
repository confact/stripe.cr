# https://stripe.com/docs/api/customer_portal/create
class Stripe::BillingPortal::Session
  def self.create(
    customer : String | Stripe::Customer,
    return_url : String? = nil,
    expand : Array(String)? = nil,
    configuration : String? = nil
  ) : Stripe::BillingPortal::Session
    customer = customer.id if customer.is_a?(Customer)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(customer return_url expand configuration) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/billing_portal/sessions", form: io.to_s)

    if response.status_code == 200
      Stripe::BillingPortal::Session.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
