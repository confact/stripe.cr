module StripeMethods
  extend self

  macro add_retrieve_method
{% begin %}
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/#{"{{@type.id.gsub(/Stripe::/, "").underscore.gsub(/::/, "/")}}"}s/#{id}")

    if response.status_code == 200
      {{@type.id}}.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve({{@type.id.gsub(/Stripe::/, "").downcase.underscore.gsub(/::/, "_").id}} : {{@type.id}})
    retrieve({{@type.id.gsub(/Stripe::/, "").downcase.underscore.gsub(/::/, "_").id}}.id)
  end
{% end %}
end
end
