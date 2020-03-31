require "../../spec_helper"

describe Stripe::PaymentMethod do
  it "retrieve payment method" do
    WebMock.stub(:get, "https://api.stripe.com/v1/payment_methods/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_payment_method.json"), headers: {"Content-Type" => "application/json"})

    stripe = Stripe.new("test")
    payment_method = stripe.retrieve_payment_method("asddad")
    payment_method.id.should eq("pm_1EUnwZ4XsdaddaBS77el70wJ")
  end
end
