class Stripe::File
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/files/#{id}")

    if response.status_code == 200
      File.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(file : File)
    retrieve(file.id)
  end
end
