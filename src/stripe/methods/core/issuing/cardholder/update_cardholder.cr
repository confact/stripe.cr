class Stripe::Issuing::Cardholder
  def self.update(id : String, params = {} of String => String)
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    params.each do |key, value|
      builder.add("#{key}", value)
    end

    response = Stripe.client.post("/v1/issuing/cardholders/#{id}", form: io.to_s)
    if response.status_code == 200
      Issuing::Cardholder.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
