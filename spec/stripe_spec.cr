require "./spec_helper"

describe Stripe do
  it "set api_key" do
    Stripe.api_key = "test"
    Stripe.api_key.should eq("test")
  end

  it "set version" do
    Stripe.version = "2020-04-02"
    Stripe.version.should eq("2020-04-02")
  end

  it "get client" do
    Stripe.client.class.name.should eq("HTTP::Client")
  end
end
