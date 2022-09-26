class Stripe::Customer
  def self.update(
    customer : String | Customer,
    balance : Int32 | Unset = Unset.new,
    coupon : String? | Unset = Unset.new,
    default_source : String | Token | Unset = Unset.new,
    name : String | Token? | Unset = Unset.new,
    description : String | Token? | Unset = Unset.new,
    email : String? | Unset = Unset.new,
    phone : String? | Unset = Unset.new,
    invoice_prefix : String | Unset = Unset.new,
    invoice_settings : U? | Unset = Unset.new,
    metadata : Hash? | Unset = Unset.new,
    shipping : T? | Unset = Unset.new,
    source : String | Token | Unset = Unset.new,
    tax_info : U? | Unset = Unset.new
  ) : Customer forall T, U
    default_source = default_source.as(Token).id if default_source.is_a?(Token)

    source = source.as(Token).id if source.is_a?(Token)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(balance coupon default_source name description email phone invoice_prefix invoice_settings metadata shipping source tax_info) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.is_a?(Unset)
    {% end %}

    case customer
    when String   then customer_id = customer
    when Customer then customer_id = customer.id
    end

    response = Stripe.client.post("/v1/customers/#{customer_id}", form: io.to_s)

    if response.status_code == 200
      Customer.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
