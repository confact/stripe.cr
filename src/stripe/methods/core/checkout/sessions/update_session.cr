class Stripe::Checkout::Session
  def self.update(
    id : String | Stripe::Checkout::Session,
    metadata : Hash(String, String)? = nil,
    expand : Array(String)? = nil
  ) : Stripe::Checkout::Session
    session_id = id.is_a?(Stripe::Checkout::Session) ? id.id : id

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(metadata expand) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/checkout/sessions/#{session_id}", form: io.to_s)

    if response.status_code == 200
      Stripe::Checkout::Session.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end


