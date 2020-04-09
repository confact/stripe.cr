class Stripe::Plan
  def self.create(
    currency : String,
    interval : String,
    product : String | Product,
    amount : Int32? = nil,
    active : Bool? = nil,
    metadata : Hash? = nil,
    nickname : String? = nil,
    id : String? = nil,
    tiers : Array(Hash)? = nil,
    tiers_mode : String? = nil,
    aggregate_usage : String? = nil,
    amount_decimal : String? = nil,
    billing_scheme : String? = nil,
    interval_count : Int32? = nil,
    trial_period_days : Int32? = nil,
    usage_type : String? = nil
  ) : Plan forall T, U
    product = product.as(Product).id if product.is_a?(Product)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(amount currency interval product active metadata nickname id tiers tiers_mode aggregate_usage amount_decimal billing_scheme interval_count trial_period_days usage_type) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/plans", form: io.to_s)

    if response.status_code == 200
      return Plan.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
