# https://stripe.com/docs/api/checkout/sessions/create
class Stripe::Checkout::Session
  def self.create(
    mode : String | Stripe::Checkout::Session::Mode,
    payment_method_types : Array(String),
    cancel_url : String,
    success_url : String,
    # Common optional params
    client_reference_id : String? = nil,
    customer : String? | Stripe::Customer? = nil,
    customer_email : String? = nil,
    # Support both price and price_data styles
    line_items : Array(
      NamedTuple(quantity: Int32, price: String) |
      NamedTuple(
        quantity: Int32,
        price_data: NamedTuple(
          currency: String,
          product_data: NamedTuple(name: String)?,
          unit_amount: Int32?,
          unit_amount_decimal: String?,
          recurring: NamedTuple(interval: String, interval_count: Int32?)?,
          tax_behavior: String?
        )
      )
    )? = nil,
    expand : Array(String)? = nil,
    subscription_data : NamedTuple(metadata: Hash(String, String)?)? = nil,
    allow_promotion_codes : Bool? = nil,
    metadata : Hash(String, String)? = nil,
    discounts : Array(NamedTuple(coupon: String) | NamedTuple(promotion_code: String))? = nil,
    payment_intent_data : Hash(String, String)? = nil,
    # Newer/extended params
    billing_address_collection : Stripe::Checkout::Session::BillingAddressCollection? = nil,
    automatic_tax : NamedTuple(enabled: Bool)? = nil,
    phone_number_collection : NamedTuple(enabled: Bool)? = nil,
    shipping_address_collection : NamedTuple(allowed_countries: Array(String))? = nil,
    shipping_options : Array(NamedTuple(shipping_rate: String))? = nil,
    submit_type : Stripe::Checkout::Session::SubmitType? = nil,
    tax_id_collection : NamedTuple(enabled: Bool)? = nil,
    # Expiration and UI
    expires_at : Time? = nil,
    ui_mode : String? = nil,
    return_url : String? = nil,
    redirect_on_completion : String? = nil,
    # Customer fields
    customer_update : NamedTuple? = nil,
    customer_creation : String | NamedTuple? = nil,
    # Invoice/payment fields
    invoice_creation : NamedTuple? = nil,
    payment_method_collection : String? = nil,
    payment_method_configuration : String? = nil,
    payment_method_options : NamedTuple? = nil,
    # Consent/customization
    consent_collection : NamedTuple? = nil,
    custom_fields : Array(NamedTuple)? = nil,
    custom_text : NamedTuple? = nil,
    # After expiration recovery
    after_expiration : NamedTuple? = nil
  ) : Stripe::Checkout::Session
    customer = customer.not_nil!.id if customer.is_a?(Customer)

    expires_at_unix = expires_at.try &.to_unix

    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(
      mode
      payment_method_types
      cancel_url
      success_url
      client_reference_id
      customer
      customer_email
      line_items
      expand
      subscription_data
      allow_promotion_codes
      metadata
      discounts
      payment_intent_data
      billing_address_collection
      automatic_tax
      phone_number_collection
      shipping_address_collection
      shipping_options
      submit_type
      tax_id_collection
      ui_mode
      return_url
      redirect_on_completion
      customer_update
      customer_creation
      invoice_creation
      payment_method_collection
      payment_method_configuration
      payment_method_options
      consent_collection
      custom_fields
      custom_text
      after_expiration
    ) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    builder.add("expires_at", expires_at_unix) unless expires_at_unix.nil?

    response = Stripe.client.post("/v1/checkout/sessions", form: io.to_s)

    if response.status_code == 200
      Stripe::Checkout::Session.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
