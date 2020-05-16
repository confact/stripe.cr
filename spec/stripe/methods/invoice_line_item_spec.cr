require "../../spec_helper"

describe Stripe::Invoice::LineItem do
  it "create invoice item" do
    WebMock.stub(:post, "https://api.stripe.com/v1/invoiceitems")
      .to_return(status: 200, body: File.read("spec/support/create_invoice_line_item.json"), headers: {"Content-Type" => "application/json"})

    invoice_item = Stripe::Invoice::LineItem.create(customer: "asdadsa", currency: "usd", amount: 20000)
    invoice_item.id.should eq("il_tmp1GiV7UA10aTTSdypla6FvHwJ")
  end
end
