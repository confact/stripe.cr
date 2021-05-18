class Stripe::Price
  def self.list(
    active : Bool? = nil,
    product : String? = nil,
    currency : String? = nil,
    type : String? = nil,
    lookup_keys : Array(String)? = nil,
    recurring : Hash(String, String | Int32 | Nil)? = nil,
    limit : Int32? = nil,
    created : Hash(String, Int32)? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  ) : List(Stripe::Price)
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(active product currency type lookup_keys recurring limit created starting_after ending_before) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.get("/v1/prices", form: io.to_s)

    if response.status_code == 200
      List(Stripe::Price).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
