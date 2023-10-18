require "../../spec_helper"

describe Stripe::Account do
  it "retrieve account" do
    WebMock.stub(:get, "https://api.stripe.com/v1/accounts/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_account.json"), headers: {"Content-Type" => "application/json"})

    account = Stripe::Account.retrieve("asddad")
    account.id.should eq("acct_1032D82eZvKYlo2C")
  end

  it "created account" do
    WebMock.stub(:post, "https://api.stripe.com/v1/accounts")
      .to_return(status: 200, body: File.read("spec/support/create_account.json"), headers: {"Content-Type" => "application/json"})

    account = Stripe::Account.create(type: Stripe::Account::Type::Express)
    account.id.should eq("acct_7772D82eZvKYlo2C")
  end
end
