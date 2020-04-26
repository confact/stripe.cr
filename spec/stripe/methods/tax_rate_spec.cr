require "../../spec_helper"

describe Stripe::TaxRate do
  it "create tax rate" do
    WebMock.stub(:post, "https://api.stripe.com/v1/tax_rates")
      .to_return(status: 200, body: File.read("spec/support/create_tax_rate.json"), headers: {"Content-Type" => "application/json"})

    tax_rate = Stripe::TaxRate.create(display_name: "test", inclusive: true, percentage: 19)
    tax_rate.id.should eq("txr_1GVxr2IfhoELGSZwvwrumvdX")
  end

  it "retrieve tax rate" do
    WebMock.stub(:get, "https://api.stripe.com/v1/tax_rates/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_tax_rate.json"), headers: {"Content-Type" => "application/json"})

    tax_rate = Stripe::TaxRate.retrieve("asddad")
    tax_rate.id.should eq("txr_1GVxr2IfhoELGSZwvwrumvdX")
  end
end
