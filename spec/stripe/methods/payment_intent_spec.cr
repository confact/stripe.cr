require "../../spec_helper"

describe Stripe::PaymentIntent do
  it "create payment intent" do
    WebMock.stub(:post, "https://api.stripe.com/v1/payment_intents")
      .to_return(status: 200, body: File.read("spec/support/create_payment_intent.json"), headers: {"Content-Type" => "application/json"})

    intent = Stripe::PaymentIntent.create(amount: 200, currency: "usd")

    intent.id.should eq("pi_1EUnwX4XsdaddaBS0K7XUB5v")
  end

  it "retrieve payment intent" do
    WebMock.stub(:get, "https://api.stripe.com/v1/payment_intents/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_payment_intent.json"), headers: {"Content-Type" => "application/json"})

    intent = Stripe::PaymentIntent.retrieve("asddad")
    intent.id.should eq("pi_1EUnwX4XsdaddaBS0K7XUB5v")
  end
end
