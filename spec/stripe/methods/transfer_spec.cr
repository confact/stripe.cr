require "../../spec_helper"

describe Stripe::Transfer do
  it "retrieve transfer" do
    WebMock.stub(:get, "https://api.stripe.com/v1/transfers/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_transfer.json"), headers: {"Content-Type" => "application/json"})

    transfer = Stripe::Transfer.retrieve("asddad")
    transfer.id.should eq("tr_6615gKA10aTTSdypCEXB1LV7")
  end

  it "created transfer" do
    WebMock.stub(:post, "https://api.stripe.com/v1/transfers")
      .to_return(status: 200, body: File.read("spec/support/create_transfer.json"), headers: {"Content-Type" => "application/json"})

    tranfer = Stripe::Transfer.create(amount: 400, currency: "usd", destination: "acct_1GdkO0A10aTTSdyp")
    tranfer.destination.should eq("acct_1GdkO0A10aTTSdyp")
  end
end
