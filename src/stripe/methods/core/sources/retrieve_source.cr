class Stripe::Source
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/sources/#{id}")

    if response.status_code == 200
      Source.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(source : Source)
    retrieve(source.id)
  end
end
