class Stripe::PaymentMethod
  def self.attach(payment_method : PaymentMethod | String, customer : Customer | String)
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    case customer
    when Customer
      builder.add("customer", customer.id)
    when String
      builder.add("customer", customer)
    end

    payment_method_id = case payment_method
                        when PaymentMethod
                          payment_method.id
                        when String
                          payment_method
                        end

    response = Stripe.client.post("/v1/payment_methods/#{payment_method_id}/attach", form: io.to_s)

    if response.status_code == 200
      PaymentMethod.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
