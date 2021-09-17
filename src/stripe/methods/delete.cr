module StripeMethods
  extend self

  macro add_delete_method
{% begin %}
  def self.delete(id : String)
    response = Stripe.client.delete("/v1/#{"{{@type.id.gsub(/Stripe::/, "").underscore.gsub(/::/, "/")}}"}s/#{id}")

    if response.status_code == 200
      {{@type.id}}.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.delete({{@type.id.gsub(/Stripe::/, "").downcase.underscore.gsub(/::/, "_").id}} : {{@type.id}})
    delete({{@type.id.gsub(/Stripe::/, "").downcase.underscore.gsub(/::/, "_").id}}.id)
  end
{% end %}
end
end
