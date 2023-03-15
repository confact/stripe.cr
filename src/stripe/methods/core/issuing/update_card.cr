class Stripe::Issuing::Card
  def self.update(
    id : String,
    cancellation_reason : String? = nil,
    status : String? = nil,
    metadata : Hash(String, String)? = nil) : self

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(cancellation_reason status metadata) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/issuing/cards/#{id}", form: io.to_s)
    if response.status_code == 200
      Issuing::Card.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

end
