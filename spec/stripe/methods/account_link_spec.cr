require "../../spec_helper"

describe Stripe::AccountLink do
  it "created account link" do
    WebMock.stub(:post, "https://api.stripe.com/v1/account_links")
      .to_return(status: 200, body: File.read("spec/support/create_account_link.json"), headers: {"Content-Type" => "application/json"})

    account_link = Stripe::AccountLink.create(account: "acct_1GdkO0A10aTTSdyp", return_url: "https://example.com/return", refresh_url: "https://example.com/refresh")
    account_link.url.should eq("https://connect.stripe.com/setup/s/acct_1GdkO0A10aTTSdyp/rHcj4DNgSIjl")
  end
end
