class Stripe::Issuing::Card
  def self.create(params = {} of String => String) : self

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    params.each do |key, value|
       builder.add("#{key}", value)
    end

    response = Stripe.client.post("/v1/issuing/cards", form: io.to_s)
    if response.status_code == 200
      Issuing::Card.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

end
