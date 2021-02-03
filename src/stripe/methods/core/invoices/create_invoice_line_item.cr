class Stripe::Invoice::LineItem
  def self.create(
    customer : String | Customer,
    currency : String,
    amount : Int32? = nil,
    quantity : Int32? = nil,
    description : String? = nil,
    unit_amount : Int32? = nil,
    invoice : String | Invoice? = nil,
    subscription : String | Subscription? = nil,
    metadata : Hash(String, String)? = nil
  ) : Invoice::LineItem forall T, U
    case customer
    when Customer
      customer = customer.id
    when Nil
      customer = nil
    end

    case invoice
    when Invoice
      invoice = invoice.id
    when Nil
      invoice = nil
    end

    case subscription
    when Subscription
      subscription = subscription.id
    when Nil
      subscription = nil
    end

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(customer amount currency quantity description unit_amount invoice subscription metadata) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/invoiceitems", form: io.to_s)

    if response.status_code == 200
      Invoice::LineItem.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
