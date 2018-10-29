class Stripe
  record CreateCustomer::Shipping,
    address : Address,
    name : String,
    phone : String? = nil do
    record Address,
      line1 : String,
      city : String? = nil,
      country : String? = nil,
      line2 : String? = nil,
      postal_code : String? = nil,
      state : String? = nil do
      def to_nt
        {% begin %}
        {
          {% for x in %w(line1 city country line2 postal_code state) %}
            {{x}}: {{x.id}},
          {% end %}
        }
      {% end %}
      end
    end

    def to_nt
      {
        address: address.to_nt,
        name:    name,
        phone:   phone,
      }
    end
  end

  record CreateCustomer::TaxInfo,
    tax_id : String,
    type : Type do
    enum Type
      Vat
    end

    def to_nt
      {
        tax_id: tax_id,
        type:   type.to_s,
      }
    end
  end

  def create_customer(
    account_balance : Int32? = nil,
    coupon : String? = nil,
    default_source : String? = nil,
    description : String | Token? = nil,
    email : String? = nil,
    invoice_prefix : String? = nil,
    metadata : Hash? = nil,
    shipping : CreateCustomer::Shipping? = nil,
    source : String | Token? = nil,
    tax_info : CreateCustomer::TaxInfo? = nil
  )
    default_source = default_source.as(Token).id if default_source.is_a?(Token)
    source = source.as(Token).id if source.is_a?(Token)

    io = IO::Memory.new
    builder = HTTP::Params::Builder.new(io)

    {% for x in %w(account_balance coupon default_source description email invoice_prefix source) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    builder.add("metadata", metadata) unless metadata.nil?
    builder.add("shipping", shipping.to_nt) unless shipping.nil?
    builder.add("tax_info", tax_info.to_nt) unless tax_info.nil?

    response = @client.post("/v1/customers", form: io.to_s)

    if response.status_code == 200
      return Customer.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
