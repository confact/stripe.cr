require "../../spec_helper"

describe Stripe::Subscription do
  it "create subscription" do
    WebMock.stub(:post, "https://api.stripe.com/v1/subscriptions")
      .to_return(status: 200, body: File.read("spec/support/create_subscription.json"), headers: {"Content-Type" => "application/json"})

    subscription = Stripe::Subscription.create(customer: "sdsadaada")
    subscription.id.should eq("sub_H0TJvm2aKdakJ7")
  end

  it "retrieve subscription" do
    WebMock.stub(:get, "https://api.stripe.com/v1/subscriptions/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_subscription.json"), headers: {"Content-Type" => "application/json"})

    subscription = Stripe::Subscription.retrieve("asddad")
    subscription.id.should eq("sub_H0TJvm2aKdakJ7")
    subscription.items.should be_truthy
    if items = subscription.items
      price_item = items.data[1]
      price_item.price.try(&.id).should eq("price_HC8jEpscAGZb8v")
    end
    subscription.discount.try(&.coupon).try(&.id).should eq("25_5OFF")
    promotion_code = subscription.discount.try(&.promotion_code)
    promotion_code.should be_a(Stripe::PromotionCode)
    if promotion_code.is_a?(Stripe::PromotionCode)
      promotion_code.id.should eq("promo_1IHHgbA10aTTSdyp5WqdgzWW")
    end
  end

  it "listing subscriptions" do
    WebMock.stub(:get, "https://api.stripe.com/v1/subscriptions")
      .to_return(status: 200, body: File.read("spec/support/list_subscriptions.json"), headers: {"Content-Type" => "application/json"})

    subscriptions = Stripe::Subscription.list
    subscriptions.first.id.should eq("su_1GVxr04XsdaddaBSSq4mVJi1")
  end

  it "update subscription" do
    WebMock.stub(:post, "https://api.stripe.com/v1/subscriptions/assaas")
      .to_return(status: 200, body: File.read("spec/support/update_subscription.json"), headers: {"Content-Type" => "application/json"})

    subscription = Stripe::Subscription.update(subscription: "assaas", cancel_at_period_end: true)
    subscription.id.should eq("sub_H0TJvm2aKdakJ7")
  end

  it "delete subscription" do
    WebMock.stub(:delete, "https://api.stripe.com/v1/subscriptions/assaas")
      .to_return(status: 200, body: File.read("spec/support/delete_subscription.json"), headers: {"Content-Type" => "application/json"})

    subscription = Stripe::Subscription.delete("assaas")
    subscription.status.should eq(Stripe::Subscription::Status::Canceled)
  end
end
