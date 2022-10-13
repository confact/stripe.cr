# https://stripe.com/docs/api/checkout/sessions/create
class Stripe::Checkout::Session
  def self.create(
    mode : String | Stripe::Checkout::Session::Mode,
    payment_method_types : Array(String),
    cancel_url : String,
    success_url : String,
    client_reference_id : String? = nil,
    customer : String? | Stripe::Customer? = nil,
    customer_email : String? = nil,
    line_items : Array(NamedTuple(quantity: Int32, price: String))? = nil,
    expand : Array(String)? = nil,
    subscription_data : NamedTuple(metadata: Hash(String, String)?)? = nil,
    allow_promotion_codes : Bool? = nil,
    metadata : Hash(String, String)? = nil,
    discounts : Array(NamedTuple(coupon: String) | NamedTuple(promotion_code: String))? = nil,
    payment_intent_data : Hash(String, String)? = nil
  ) : Stripe::Checkout::Session
    customer = customer.not_nil!.id if customer.is_a?(Customer)

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(mode payment_method_types cancel_url success_url client_reference_id customer customer_email line_items expand subscription_data allow_promotion_codes metadata discounts payment_intent_data) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Stripe.client.post("/v1/checkout/sessions", form: io.to_s)

    if response.status_code == 200
      Stripe::Checkout::Session.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
