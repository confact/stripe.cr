require "../../spec_helper"

describe Stripe::Subscription do
  it "create subscription" do
    WebMock.stub(:post, "https://api.stripe.com/v1/subscriptions")
      .to_return(status: 200, body: File.read("spec/support/create_subscription.json"), headers: {"Content-Type" => "application/json"})

    subscription = Stripe::Subscription.create(customer: "sdsadaada", plan: "monthly")
    subscription.id.should eq("sub_H0TJvm2aKdakJ7")
  end

  it "retrieve subscription" do
    WebMock.stub(:get, "https://api.stripe.com/v1/subscriptions/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_subscription.json"), headers: {"Content-Type" => "application/json"})

    subscription = Stripe::Subscription.retrieve("asddad")
    subscription.id.should eq("sub_H0TJvm2aKdakJ7")
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
