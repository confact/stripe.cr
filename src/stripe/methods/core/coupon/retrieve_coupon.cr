class Stripe::Coupon
  def self.retrieve(id : String)
    response = Stripe.client.get("/v1/coupons/#{id}")

    if response.status_code == 200
      Coupon.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(coupon : Coupon)
    retrieve(coupon.id)
  end
end
