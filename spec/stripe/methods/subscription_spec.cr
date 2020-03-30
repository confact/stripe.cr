require "../../spec_helper"

describe Stripe::Subscription do
  it "create subscription" do
    WebMock.stub(:post, "https://api.stripe.com/v1/subscriptions")
      .to_return(status: 200, body: File.read("spec/support/create_subscription.json"), headers: {"Content-Type" => "application/json"})

    stripe = Stripe.new("test")
    subscription = stripe.create_subscription(customer: "sdsadaada", plan: "monthly")
    subscription.id.should eq("sub_3ewdhCIki3FxWt")
  end

  it "retrieve subscription" do
    WebMock.stub(:post, "https://api.stripe.com/v1/subscriptions")
      .to_return(status: 200, body: File.read("spec/support/create_subscription.json"), headers: {"Content-Type" => "application/json"})

    stripe = Stripe.new("test")
    subscription = stripe.create_subscription(customer: "sdsadaada", plan: "monthly")
    subscription.id.should eq("sub_3ewdhCIki3FxWt")
  end
end
