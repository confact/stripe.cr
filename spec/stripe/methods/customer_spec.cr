require "../../spec_helper"

describe Stripe::Customer do
  it "create customer" do
    WebMock.stub(:post, "https://api.stripe.com/v1/customers")
      .to_return(status: 200, body: File.read("spec/support/create_customer.json"), headers: {"Content-Type" => "application/json"})

    stripe = Stripe.new("test")
    customer = stripe.create_customer(email: "test@ex.com", description: "test")
    customer.id.should eq("abcdefghijklmnop")
    customer.sources.not_nil!.data.first.id.should eq("card_1234567890ABCDEFghijklmn")
  end

  it "retrieve customer" do
    WebMock.stub(:get, "https://api.stripe.com/v1/customers/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_customer.json"), headers: {"Content-Type" => "application/json"})

    stripe = Stripe.new("test")
    customer = stripe.retrieve_customer("asddad")
    customer.id.should eq("cus_H0TJWPA6bGxoTk")
  end

  it "update customer" do
    WebMock.stub(:post, "https://api.stripe.com/v1/customers/assaas")
      .to_return(status: 200, body: File.read("spec/support/update_customer.json"), headers: {"Content-Type" => "application/json"})

    stripe = Stripe.new("test")
    customer = stripe.update_customer(customer: "assaas", email: "test@ex.com")
    customer.id.should eq("cus_H0TJWPA6bGxoTk")
  end
end
