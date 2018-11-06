class Stripe
  def update_customer(
    customer : String | Customer,
    account_balance : Int32 | Unset = Unset.new,
    coupon : String? | Unset = Unset.new,
    default_source : String | Token | Unset = Unset.new,
    description : String | Token? | Unset = Unset.new,
    email : String? | Unset = Unset.new,
    invoice_prefix : String | Unset = Unset.new,
    metadata : Hash? | Unset = Unset.new,
    shipping : T? | Unset = Unset.new,
    source : String | Token | Unset = Unset.new,
    tax_info : U? | Unset = Unset.new
  ) : Customer forall T, U
    default_source = default_source.as(Token).id if default_source.is_a?(Token)

    validate shipping, {{T}} do
      type address do
        type line1 : String
        type city : String? = nil
        type country : String? = nil
        type line2 : String? = nil
        type postal_code : String? = nil
        type state : String? = nil
      end

      type name : String
      type phone : String? = nil
    end

    source = source.as(Token).id if source.is_a?(Token)

    validate tax_info, {{U}} do
      type tax_id : String
      type type : Customer::TaxInfo::Type
    end

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(account_balance coupon default_source description email invoice_prefix metadata shipping source tax_info) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.is_a?(Unset)
    {% end %}

    case customer
    when String   then customer_id = customer
    when Customer then customer_id = customer.id
    end

    response = @client.post("/v1/customers/#{customer_id}", form: io.to_s)

    if response.status_code == 200
      return Customer.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
