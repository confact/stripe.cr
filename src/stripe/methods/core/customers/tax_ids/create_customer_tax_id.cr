class Stripe::Customer
  def self.create_tax_id(
    customer : String | Stripe::Customer,
    type : String,
    value : String
  ) : Customer::TaxID forall T, U
    customer = customer.id if customer.is_a?(Stripe::Customer)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(type value) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/customers/#{customer}/tax_ids", form: io.to_s)

    if response.status_code == 200
      Customer::TaxID.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
