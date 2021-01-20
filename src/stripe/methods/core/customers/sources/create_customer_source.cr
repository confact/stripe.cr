class Stripe::Customer
  def self.create_source(
    customer : String | Stripe::Customer,
    source : String | Stripe::Source
  ) : Source forall T, U
    customer = customer.id if customer.is_a?(Stripe::Customer)

    source = source.id if source.is_a?(Stripe::Source)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(source) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/customers/#{customer}/sources", form: io.to_s)

    if response.status_code == 200
      Source.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
