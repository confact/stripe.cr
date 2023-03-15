class Stripe::Topup
  def self.cancel(id : String, params = {} of String => String) : self

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    params.each do |key, value|
       builder.add("#{key}", value)
    end

    response = Stripe.client.post("/v1/topups/#{id}/cancel", form: io.to_s)
    if response.status_code == 200
      Topup.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

end
