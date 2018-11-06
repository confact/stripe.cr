class Stripe
  def create_customer(
    account_balance : Int32? = nil,
    coupon : String? = nil,
    default_source : String | Token? = nil,
    description : String | Token? = nil,
    email : String? = nil,
    invoice_prefix : String? = nil,
    metadata : Hash? = nil,
    shipping : T? = nil,
    source : String | Token | PaymentMethods::Card? = nil,
    tax_info : U? = nil
  ) : Customer forall T, U
    case default_source
    when Token
      default_source = default_source.id
    end

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

    case source
    when Token, PaymentMethods::Card
      source = source.id
    end

    validate tax_info, {{U}} do
      type tax_id : String
      type type : Customer::TaxInfo::Type
    end

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(account_balance coupon default_source description email invoice_prefix metadata shipping source tax_info) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = @client.post("/v1/customers", form: io.to_s)

    if response.status_code == 200
      return Customer.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
