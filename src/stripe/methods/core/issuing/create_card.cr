class Stripe::Issuing::Card
  def self.create(
    cardholder : String,
    currency : String,
    type : String,
    metadata : Hash(String, String)? = nil,
    status : String? = nil,
    replacement_for : String? = nil,
    replacement_reason : ReplacementReason? = nil,
    shipping : Shipping? = nil  ) : self

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    builder.add("cardholder", cardholder)
    builder.add("currency", currency)
    builder.add("type", type)

    {% for x in %w(cardholder currency type  status replacement_reason  shipping metadata) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/issuing/cards", form: io.to_s)
    if response.status_code == 200
      Issuing::Card.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def update!(api : API = Citta.stripe_api, *, status : Status? = nil)
    Card.update!(api, id: self.id, status: status)
  end

end
