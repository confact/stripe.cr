class Stripe::Checkout::Session
  def self.line_items(
    id : String | Stripe::Checkout::Session,
    limit : Int32? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  ) : List(Stripe::Checkout::LineItem)
    session_id = id.is_a?(Stripe::Checkout::Session) ? id.id : id

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(limit starting_after ending_before) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.get("/v1/checkout/sessions/#{session_id}/line_items", form: io.to_s)

    if response.status_code == 200
      List(Stripe::Checkout::LineItem).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
