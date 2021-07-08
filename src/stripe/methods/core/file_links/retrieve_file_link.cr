class Stripe::FileLink
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/file_links/#{id}")

    if response.status_code == 200
      FileLink.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(file_link : FileLink)
    retrieve(file_link.id)
  end
end
