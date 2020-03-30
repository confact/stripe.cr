require "../../spec_helper"

describe Stripe::Customer do
  it "create customer" do
    WebMock.stub(:post, "https://api.stripe.com/v1/customers")
      .to_return(status: 200, body: File.read("spec/support/create_customer.json"), headers: {"Content-Type" => "application/json"})

    stripe = Stripe.new("test")
    customer = stripe.create_customer(email: "test@ex.com", description: "test")
    customer.id.should eq("abcdefghijklmnop")
  end
end
