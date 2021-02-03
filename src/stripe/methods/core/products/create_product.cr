class Stripe::Product
  def self.create(
    name : String,
    active : Bool? = nil,
    description : String? = nil,
    metadata : Hash? = nil,
    images : Array(String)? = nil,
    statement_descriptor : String? = nil,
    unit_label : String? = nil,
    type : String? = nil
  ) : Product forall T, U
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(name active description metadata images statement_descriptor unit_label) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/products", form: io.to_s)

    if response.status_code == 200
      Product.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
