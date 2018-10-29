class Stripe
  record CreateCardToken::Card,
    exp_month : Int32,
    exp_year : Int32,
    number : String,
    currency : String? = nil,
    cvc : Int32? = nil,
    name : String? = nil,
    address_line1 : String? = nil,
    address_line2 : String? = nil,
    address_city : String? = nil,
    address_state : String? = nil,
    address_zip : String? = nil,
    address_country : String? = nil do
    def to_nt
      {% begin %}
        {
          {% for x in %w(exp_month exp_year number currency cvc name address_line1 address_line2 address_city address_state address_zip address_country) %}
            {{x}}: {{x.id}},
          {% end %}
        }
      {% end %}
    end
  end

  def create_card_token(
    card : CreateCardToken::Card? = nil,
    customer : String | Customer? = nil
  )
    customer = customer.as(Customer).id if customer.is_a?(Customer)

    io = IO::Memory.new
    builder = HTTP::Params::Builder.new(io)

    builder.add("card", card.to_nt)
    builder.add("customer", customer) if customer

    response = @client.post("/v1/tokens", form: io.to_s)

    if response.status_code == 200
      return Token.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
