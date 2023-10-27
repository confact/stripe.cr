class Stripe::Transfer
  def self.create(
    amount : Int32,
    destination : String | Stripe::Account,
    currency : String,
    description : String? = nil
  ) : Transfer forall T, U
    destination = destination.id if destination.is_a?(Stripe::Account)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(amount destination currency description) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/transfers", form: io.to_s)

    if response.status_code == 200
      Transfer.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
