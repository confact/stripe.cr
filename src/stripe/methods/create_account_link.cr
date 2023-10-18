class Stripe::AccountLink
  def self.create(
    account : String | Stripe::Account,
    refresh_url : String,
    return_url : String
  ) : AccountLink forall T, U
    account = account.id if account.is_a?(Stripe::Account)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(account refresh_url return_url) %}
        builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
      {% end %}

    response = Stripe.client.post("/v1/account_links", form: io.to_s)

    if response.status_code == 200
      AccountLink.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
