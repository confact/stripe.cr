class Stripe::Subscription
  def self.list(
    customer : String? = nil,
    plan : String? = nil,
    status : String? | Stripe::Subscription::Status? = nil,
    limit : Int32? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  ) : List(Stripe::Subscription)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(customer plan status limit starting_after ending_before) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.get("/v1/subscriptions", form: io.to_s)
    
    if response.status_code == 200
      return List(Stripe::Subscription).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
