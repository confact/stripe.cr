class Stripe::Address
  include JSON::Serializable

  getter city : String?
  getter country : String? # https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
  getter line1 : String?
  getter line2 : String?
  getter postal_code : String?
  getter state : String?
  getter town : String?

  def initialize(@line1, @city, @state, @line2 = nil, @postal_code = nil, @country = nil, @town = nil)
  end

  def to_h
    data = Hash(String, String?).new
    {% for x in %w(city country line1 line2 postal_code state town) %}
      data[{{x}}] = {{x.id}} unless {{x.id}}.nil?
    {% end %}
    data
  end
end
