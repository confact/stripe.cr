class Stripe::Checkout::LineItem
  include JSON::Serializable

  getter id : String?
  getter object : String? = "item"

  getter amount_discount : Int32?
  getter amount_subtotal : Int32?
  getter amount_tax : Int32?
  getter amount_total : Int32?

  getter currency : String?
  getter description : String?

  getter price : Stripe::Price?
  getter quantity : Int32?
end
