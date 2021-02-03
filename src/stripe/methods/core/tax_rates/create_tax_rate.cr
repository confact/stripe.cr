class Stripe::TaxRate
  def self.create(
    display_name : String,
    inclusive : Bool,
    percentage : Int32,
    active : Bool = true,
    description : String? = nil,
    jurisdiction : String? = nil
  ) : TaxRate forall T, U
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(display_name inclusive percentage active description jurisdiction) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/tax_rates", form: io.to_s)

    if response.status_code == 200
      TaxRate.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
