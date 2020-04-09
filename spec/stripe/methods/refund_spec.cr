require "../../spec_helper"

describe Stripe::Refund do
  it "create refund" do
    WebMock.stub(:post, "https://api.stripe.com/v1/refunds")
      .to_return(status: 200, body: File.read("spec/support/create_refund.json"), headers: {"Content-Type" => "application/json"})

    refund = Stripe::Refund.create

    refund.id.should eq("re_1GVxr1IfhoELGSZwsYg0cUmI")
  end

  it "retrieve refund" do
    WebMock.stub(:get, "https://api.stripe.com/v1/refunds/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_refund.json"), headers: {"Content-Type" => "application/json"})

    refund = Stripe::Refund.retrieve("asddad")
    refund.id.should eq("re_1GVxr1IfhoELGSZwsYg0cUmI")
  end
end
