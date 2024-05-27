class Stripe::Account
  def self.update(
    account : String | Stripe::Account,
    country : String? = nil,
    email : String? = nil,
    capabilities : Array(String)? = nil,
    business_type : String | Stripe::Account::BusinessType? = nil,
    company : Stripe::Account::Company? = nil,
    individual : Stripe::Account::Individual? = nil,
    metadata : Hash? = nil,
    tos_acceptance : Stripe::Account::TOSAcceptance? = nil,
    default_currency : String? = nil,
    settings : Stripe::Account::Settings? = nil
  ) : Account forall T, U
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    account = account.id if account.is_a?(Account)

    business_type = business_type.to_s.downcase if business_type.is_a?(Account::BusinessType)

    {% for x in %w(country email business_type metadata default_currency) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    if s = settings
      builder.add "settings", s.to_h
    end

    if capabilities.is_a?(Array)
      capabilities.each do |capability|
        # tried fancier invocations like Hash{capability.downcase => {"requested" => true}} but broke the tests
        builder.add("capabilities[#{capability.downcase}][requested]", true)
      end
    end

    builder.add("company", company.to_h) if company.is_a?(Account::Company)
    builder.add("individual", individual.to_h) if individual.is_a?(Account::Individual)
    builder.add("tos_acceptance", tos_acceptance.to_h) if tos_acceptance.is_a?(Account::TOSAcceptance)

    response = Stripe.client.post("/v1/accounts/#{account}", form: io.to_s)

    if response.status_code == 200
      Account.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
