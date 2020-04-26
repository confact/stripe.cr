class Stripe::Customer
  def self.list(
    email : String? = nil,
    created : Hash(String, Int32)? = nil,
    limit : Int32? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  ) : List(Customer)
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(email created limit starting_after ending_before) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.get("/v1/customers", form: io.to_s)

    if response.status_code == 200
      return List(Customer).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
