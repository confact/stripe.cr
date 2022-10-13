require "../../spec_helper"

describe Stripe::Customer do
  it "create customer" do
    WebMock.stub(:post, "https://api.stripe.com/v1/customers")
      .to_return(status: 200, body: File.read("spec/support/create_customer.json"), headers: {"Content-Type" => "application/json"})

    customer = Stripe::Customer.create(email: "test@ex.com", description: "test")
    customer.id.should eq("abcdefghijklmnop")
    customer.sources.not_nil!.data.first.id.should eq("card_1234567890ABCDEFghijklmn")
    customer.balance.should eq(0)
  end

  it "retrieve customer" do
    WebMock.stub(:get, "https://api.stripe.com/v1/customers/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_customer.json"), headers: {"Content-Type" => "application/json"})

    customer = Stripe::Customer.retrieve("asddad")
    customer.id.should eq("cus_H0TJWPA6bGxoTk")
  end

  it "list customer" do
    WebMock.stub(:get, "https://api.stripe.com/v1/customers")
      .to_return(status: 200, body: File.read("spec/support/list_customers.json"), headers: {"Content-Type" => "application/json"})

    customers = Stripe::Customer.list
    customers.first.id.should eq("cus_H4637xPCSXL0I7")
  end

  it "update customer" do
    WebMock.stub(:post, "https://api.stripe.com/v1/customers/assaas")
      .to_return(status: 200, body: File.read("spec/support/update_customer.json"), headers: {"Content-Type" => "application/json"})

    customer = Stripe::Customer.update(customer: "assaas", email: "test@ex.com")
    customer.id.should eq("cus_H0TJWPA6bGxoTk")
  end

  it "delete customer" do
    WebMock.stub(:delete, "https://api.stripe.com/v1/customers/assaas")
      .to_return(status: 200, body: File.read("spec/support/delete_customer.json"), headers: {"Content-Type" => "application/json"})

    customer = Stripe::Customer.delete("assaas")
    customer.deleted.should eq(true)
  end
end
