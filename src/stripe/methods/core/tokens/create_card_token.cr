class Stripe
  def create_card_token(
    card : T? = nil,
    customer : String | Customer? = nil
  ) : Token forall T
    validate card, {{T}} do
      type exp_month : Int32
      type exp_year : Int32
      type number : String
      type currency : String? = nil
      type cvc : Int32? = nil
      type name : String? = nil
      type address_line1 : String? = nil
      type address_line2 : String? = nil
      type address_city : String? = nil
      type address_state : String? = nil
      type address_zip : String? = nil
      type address_country : String? = nil
    end

    customer = customer.as(Customer).id if customer.is_a?(Customer)

    io = IO::Memory.new
    builder = HTTP::Params::Builder.new(io)

    builder.add("card", card) if card
    builder.add("customer", customer) if customer

    response = @client.post("/v1/tokens", form: io.to_s)

    if response.status_code == 200
      return Token.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
