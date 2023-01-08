module StripeMethods
  extend self

  macro add_list_method(*arguments)
{% begin %}
  def self.list({{*arguments}}) :  List({{@type.id}})
  io = IO::Memory.new
  builder = ParamsBuilder.new(io)

  {% for x in arguments.map &.var.id %}
    builder.add({{x.stringify}}, {{x.id}}) unless {{x.id}}.nil?
  {% end %}

  response = Stripe.client.get("/v1/#{"{{@type.id.gsub(/Stripe::/, "").underscore.gsub(/::/, "/")}}"}s", form: io.to_s)

  if response.status_code == 200
    List({{@type.id}}).from_json(response.body)
  else
    raise Error.from_json(response.body, "error")
  end
  end

{% end %}
end
end
