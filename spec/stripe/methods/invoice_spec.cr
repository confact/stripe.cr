require "../../spec_helper"

describe Stripe::Invoice do
  it "create invoice" do
    WebMock.stub(:post, "https://api.stripe.com/v1/invoices")
      .to_return(status: 200, body: File.read("spec/support/create_invoice.json"), headers: {"Content-Type" => "application/json"})

    invoice = Stripe::Invoice.create(customer: "asdadsa")
    invoice.id.should eq("in_1GSSMkIfhoELGSZww9EgmgFP")
  end

  it "retrieve invoice" do
    WebMock.stub(:get, "https://api.stripe.com/v1/invoices/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_invoice.json"), headers: {"Content-Type" => "application/json"})

    invoice = Stripe::Invoice.retrieve("asddad")
    invoice.id.should eq("in_1GSSMkIfhoELGSZww9EgmgFP")
  end

  it "listing invoices" do
    WebMock.stub(:get, "https://api.stripe.com/v1/invoices")
      .to_return(status: 200, body: File.read("spec/support/list_invoice.json"), headers: {"Content-Type" => "application/json"})

    invoices = Stripe::Invoice.list
    invoices.first.id.should eq("in_1GVxr0IfhoELGSZwxN9g4m2K")
  end

  it "update invoice" do
    WebMock.stub(:post, "https://api.stripe.com/v1/invoices/assaas")
      .to_return(status: 200, body: File.read("spec/support/update_invoice.json"), headers: {"Content-Type" => "application/json"})

    invoice = Stripe::Invoice.update(invoice: "assaas", auto_advance: true)
    invoice.id.should eq("in_1GSSMkIfhoELGSZww9EgmgFP")
  end
end
