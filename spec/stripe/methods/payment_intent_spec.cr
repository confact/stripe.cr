require "../../spec_helper"

describe Stripe::PaymentIntent do
  it "create payment intent" do
    WebMock.stub(:post, "https://api.stripe.com/v1/payment_intents")
      .to_return(status: 200, body: File.read("spec/support/create_payment_intent.json"), headers: {"Content-Type" => "application/json"})

    stripe = Stripe.new("test")
    intent = stripe.create_payment_intent

    intent.id.should eq("pi_1GSdxwIfhoELGSZwHJ9Kcws7")
  end

  it "retrieve payment intent" do
    WebMock.stub(:get, "https://api.stripe.com/v1/payment_intents/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_payment_intent.json"), headers: {"Content-Type" => "application/json"})

    stripe = Stripe.new("test")
    intent = stripe.retrieve_payment_intent("asddad")
    intent.id.should eq("pi_1GSdxwIfhoELGSZwHJ9Kcws7")
  end
end
