require "json"
require "http/client"
require "./ext/**"

class Stripe
  struct Unset
  end

  BASE_URL = URI.parse("https://api.stripe.com")

  def initialize(api_key : String)
    @client = HTTP::Client.new(BASE_URL)
    @client.before_request do |request|
      request.headers["Authorization"] = "Bearer #{api_key}"
    end
  end

  private macro validate(arg, source, &block)
    {% for exp in block.body.expressions %}
      {% if !exp.block %}
        {%
          declaration = exp.args[0]

          unless source == Nil || source <= Stripe::Unset
            if declaration.value.is_a?(Nop)
              raise "Missing #{arg}[#{declaration.var}] argument" unless source.named_args[declaration.var]
            end

            actual_type = source.named_args[declaration.var]
            match = false

            if declaration.type.is_a?(Union)
              match = declaration.type.types.any? do |t|
                (actual_type.is_a?(NilLiteral) && t.resolve.nilable?) || (!actual_type.is_a?(NilLiteral) && actual_type.resolve <= t.resolve)
              end
            else
              match = (actual_type.is_a?(NilLiteral) && declaration.type.resolve.nilable?) || (!actual_type.is_a?(NilLiteral) && actual_type.resolve <= declaration.type.resolve)
            end

            raise "Expected #{arg}[#{declaration.var}] to be #{declaration.type}, not #{actual_type}" unless match
          end
        %}
      {% else %}
        {% name = exp.args[0] %}
        {% unless source == Nil || source <= Stripe::Unset %}
          {% new_source = source.named_args[name.symbolize] %}
          {% if new_source.is_a?(Generic) && new_source.name.stringify == "NamedTuple" %}
            validate({{"#{arg}[#{name}]".id}}, {{new_source}}) {{exp.block}}
          {% else %}
            {% raise "Expected #{arg}[#{name}] to be NamedTuple, not #{new_source}" %}
          {% end %}
        {% end %}
      {% end %}
    {% end %}
  end
end

require "./stripe/*"
