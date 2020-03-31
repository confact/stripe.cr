require "../../spec_helper"

describe Stripe::Subscription do
  it "create subscription" do
    WebMock.stub(:post, "https://api.stripe.com/v1/subscriptions")
      .to_return(status: 200, body: File.read("spec/support/create_subscription.json"), headers: {"Content-Type" => "application/json"})

    stripe = Stripe.new("test")
    subscription = stripe.create_subscription(customer: "sdsadaada", plan: "monthly")
    subscription.id.should eq("sub_H0TJvm2aKdakJ7")
  end

  it "retrieve subscription" do
    WebMock.stub(:get, "https://api.stripe.com/v1/subscriptions/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_subscription.json"), headers: {"Content-Type" => "application/json"})

    stripe = Stripe.new("test")
    subscription = stripe.retrieve_subscription("asddad")
    subscription.id.should eq("sub_H0TJvm2aKdakJ7")
  end

  it "update subscription" do
    WebMock.stub(:post, "https://api.stripe.com/v1/subscriptions/assaas")
      .to_return(status: 200, body: File.read("spec/support/update_subscription.json"), headers: {"Content-Type" => "application/json"})

    stripe = Stripe.new("test")
    subscription = stripe.update_subscription(subscription: "assaas", cancel_at_period_end: true)
    subscription.id.should eq("sub_H0TJvm2aKdakJ7")
  end
end
