class Stripe::Account
  def self.create(
    type : Stripe::Account::Type,
    country : String? = nil,
    email : String? = nil,
    capabilities : Stripe::Account::Capabilities? = nil,
    business_type : Stripe::Account::BusinessType? = nil,
    company : Stripe::Account::Individual? = nil,
    individual : Stripe::Account::Company? = nil,
    metadata : Hash? = nil,
    tos_acceptance : Stripe::Account::TOSAcceptance? = nil,
    default_currency : String? = nil,
    settings : Stripe::Account::Settings? = nil
  ) : Account forall T, U
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    type = type.to_s.downcase

    {% for x in %w(type country email capabilities business_type company individual metadata tos_acceptance default_currency settings) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/accounts", form: io.to_s)

    if response.status_code == 200
      Account.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
