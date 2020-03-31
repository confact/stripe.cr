require "../../spec_helper"

describe Stripe::Charge do
  it "create charge" do
    WebMock.stub(:post, "https://api.stripe.com/v1/charges")
      .to_return(status: 200, body: File.read("spec/support/create_charge.json"), headers: {"Content-Type" => "application/json"})

    stripe = Stripe.new("test")
    charge = stripe.create_charge(amount: 1000, currency: "usd", customer: "adsssda")

    charge.id.should eq("ch_17hjFm2eZvKYlo2Cf6ceKOqV")
  end
end
