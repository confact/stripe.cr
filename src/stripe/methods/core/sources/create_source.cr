class Stripe::Source
  def self.create(
    type : String,
    amount : Int32? = nil,
    currency : String? = nil,
    metadata : U? = nil,
    owner : U? = nil,
    redirect : U? = nil,
    statement_descriptor : String? = nil,
    flow : String? = nil,
    token : String? = nil,
    usage : String? = nil,
    expand : Array(String)? = nil
  ) : Source forall T, U
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(type amount currency metadata owner redirect statement_descriptor flow token usage expand) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/sources", form: io.to_s)

    if response.status_code == 200
      Source.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
