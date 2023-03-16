module StripeMethods
  extend self

  macro add_create_method(*arguments)
{% begin %}
  def self.create({{*arguments}})
  io = IO::Memory.new
  builder = ParamsBuilder.new(io)

  {% for x in arguments.map &.var.id %}
    builder.add({{x.stringify}}, {{x.id}}) unless {{x.id}}.nil?
  {% end %}

  response = Stripe.client.post("/v1/#{"{{@type.id.gsub(/Stripe::/, "").underscore.gsub(/::/, "/")}}"}s", form: io.to_s)

  if response.status_code == 200
    {{@type.id}}.from_json(response.body)
  else
    raise Error.from_json(response.body, "error")
  end
  end

{% end %}
end
end
