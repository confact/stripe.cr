class Stripe::Invoice
  def self.update(
    invoice : String | Invoice,
    auto_advance : Bool? = nil,
    default_source : String | Token? = nil,
    default_payment_method : String | Token? = nil,
    metadata : Hash? = nil,
    subscription : String? = nil,
    statement_descriptor : String? = nil
  ) : Invoice forall T, U
    default_source = default_source.as(Token).id if default_source.is_a?(Token)

    default_payment_method = default_payment_method.as(Token).id if default_payment_method.is_a?(Token)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(auto_advance default_source metadata default_payment_method subscription statement_descriptor) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.is_a?(Unset)
    {% end %}

    case invoice
    when String  then invoice_id = invoice
    when Invoice then invoice_id = invoice.id
    end

    response = Stripe.client.post("/v1/invoices/#{invoice_id}", form: io.to_s)

    if response.status_code == 200
      Invoice.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
