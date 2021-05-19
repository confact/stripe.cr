class Stripe::Product
  def self.list(
    active : Bool? = nil,
    created : Hash(String, Int32)? = nil,
    ids : Array(String)? = nil,
    shippable : Bool? = nil,
    url : String? = nil,
    limit : Int32? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  ) : List(Stripe::Product)
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(active created ids shippable url limit starting_after ending_before) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.get("/v1/products", form: io.to_s)

    if response.status_code == 200
      List(Stripe::Product).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
