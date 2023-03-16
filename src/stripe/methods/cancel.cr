module StripeMethods
  extend self

  macro add_cancel_method
{% begin %}
  def self.cancel(id : String)
    response = Stripe.client.post("/v1/#{"{{@type.id.gsub(/Stripe::/, "").underscore.gsub(/::/, "/")}}"}s/#{id}/cancel")

    if response.status_code == 200
      {{@type.id}}.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.cancel({{@type.id.gsub(/Stripe::/, "").downcase.underscore.gsub(/::/, "_").id}} : {{@type.id}})
    cancel({{@type.id.gsub(/Stripe::/, "").downcase.underscore.gsub(/::/, "_").id}}.id)
  end
{% end %}
end
end
