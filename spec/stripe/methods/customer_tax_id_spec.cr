require "../../spec_helper"

describe Stripe::Customer::TaxID do
  it "create customer tax id" do
    WebMock.stub(:post, "https://api.stripe.com/v1/customers/test_c/tax_ids")
      .to_return(status: 200, body: File.read("spec/support/create_customer_tax_id.json"), headers: {"Content-Type" => "application/json"})

    tax_id = Stripe::Customer.create_tax_id(customer: "test_c", type: "DE", value: "adsdsaa")
    tax_id.class.name.should eq("Stripe::Customer::TaxID")
    tax_id.id.should eq("txi_123456789")
  end

  it "retrieve customer tax id" do
    WebMock.stub(:get, "https://api.stripe.com/v1/customers/test_c/tax_ids/test")
      .to_return(status: 200, body: File.read("spec/support/retrieve_customer_tax_id.json"), headers: {"Content-Type" => "application/json"})

    tax_id = Stripe::Customer.retrieve_tax_id("test_c", "test")
    tax_id.class.name.should eq("Stripe::Customer::TaxID")
    tax_id.id.should eq("txi_123456789")
    tax_id.type.should eq("eu_vat")
  end
end
