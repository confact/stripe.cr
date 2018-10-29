class Stripe
  record CreateCharge::Destination,
    account : String,
    amount : Int32? = nil do
    def to_nt
      {
        account: account,
        amount:  amount,
      }
    end
  end

  record CreateCharge::Shipping,
    address : Address,
    name : String,
    carrier : String? = nil,
    phone : String? = nil,
    tracking_number : String? = nil do
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
        address:         address.to_nt,
        name:            name,
        carrier:         carrier,
        phone:           phone,
        tracking_number: tracking_number,
      }
    end
  end

  def create_charge(
    amount : Int32,
    currency : String,
    application_fee : Int32? = nil,
    capture : Bool? = nil,
    customer : String | Customer? = nil,
    description : String? = nil,
    destination : CreateCharge::Destination? = nil,
    metadata : Hash(String, String)? = nil,
    on_behalf_of : String? = nil,
    receipt_email : String? = nil,
    shipping : CreateCharge::Shipping? = nil,
    source : String | Token | PaymentMethods::Card | PaymentMethods::BankAccount? = nil,
    statement_descriptor : String? = nil,
    transfer_group : String? = nil
  )
    customer = customer.as(Customer).id if customer.is_a?(Customer)

    case source
    when Token, PaymentMethods::Card, PaymentMethods::BankAccount
      source = source.as(Token | PaymentMethods::Card | PaymentMethods::BankAccount).id
    end

    io = IO::Memory.new
    builder = HTTP::Params::Builder.new(io)

    {% for x in %w(amount currency application_fee capture customer description on_behalf_of receipt_email source statement_descriptor transfer_group) %}
      builder.add({{x}}, {{x.id}}.to_s) unless {{x.id}}.nil?
    {% end %}

    builder.add("destination", destination.to_nt) unless destination.nil?
    builder.add("metadata", metadata) unless metadata.nil?
    builder.add("shipping", shipping.to_nt) unless shipping.nil?

    response = @client.post("/v1/charges", form: io.to_s)

    if response.status_code == 200
      return Charge.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
