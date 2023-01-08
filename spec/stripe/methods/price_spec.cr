require "../../spec_helper"

describe Stripe::Price do
  it "listing prices" do
    WebMock.stub(:get, "https://api.stripe.com/v1/prices")
      .to_return(status: 200, body: File.read("spec/support/list_prices.json"), headers: {"Content-Type" => "application/json"})

    prices = Stripe::Price.list
    prices.first.id.should eq("price_1IqjDxJN5FrkuvKhKExUK1B2")
  end

  it "listing prices with params" do
    WebMock.stub(:get, "https://api.stripe.com/v1/prices")
      .with(body: "currency=AUD")
      .to_return(status: 200, body: File.read("spec/support/list_prices.json"), headers: {"Content-Type" => "application/json"})

    prices = Stripe::Price.list(currency: "AUD")
    prices.first.id.should eq("price_1IqjDxJN5FrkuvKhKExUK1B2")
  end
end
