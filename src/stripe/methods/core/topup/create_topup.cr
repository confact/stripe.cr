class Stripe::Topup
  def self.create(params = {} of String => String)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    params.each do |key, value|
       builder.add("#{key}", value)
    end

    response = Stripe.client.post("/v1/topups", form: io.to_s)
    if response.status_code == 200
      Topup.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

end
