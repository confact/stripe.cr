class Stripe::Token
  def self.create(
    card : T? = nil,
    customer : String | Customer? = nil,
    expand : Array(String)? = nil
  ) : Token forall T
    customer = customer.as(Customer).id if customer.is_a?(Customer)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    builder.add("card", card) if card
    builder.add("customer", customer) if customer
    builder.add("expand", expand) if expand

    response = Stripe.client.post("/v1/tokens", form: io.to_s)

    if response.status_code == 200
      Token.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
