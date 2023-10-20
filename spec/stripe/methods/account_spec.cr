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

    account = Stripe::Account.create(
      type: Stripe::Account::Type::Express,
      business_type: Stripe::Account::BusinessType::Company,
      capabilities: ["transfers"],
      company: Stripe::Account::Company.new(
        name: "Acme, Inc.",
        address: Stripe::Address.new(line1: "123 Street", city: "Nowhereville", state: "TX", postal_code: "98756"),
        phone: "111-2222",
      ),
      individual: Stripe::Account::Individual.new(
        first_name: "John",
        last_name: "Doe",
        address: Stripe::Address.new(line1: "123 Street", city: "Nowhereville", state: "TX", postal_code: "98756"),
        phone: "111-2222",
        email: "johhnydoe@example.com",
      ),
    )
    account.id.should eq("acct_7772D82eZvKYlo2C")
  end

  it "updated account" do
    WebMock.stub(:post, "https://api.stripe.com/v1/accounts/acct_7772D82eZvKYlo2C")
      .to_return(status: 200, body: File.read("spec/support/create_account.json"), headers: {"Content-Type" => "application/json"})

    account = Stripe::Account.update(
      account: "acct_7772D82eZvKYlo2C",
      business_type: "company",
      company: Stripe::Account::Company.new(
        name: "Acme, Inc.",
        address: Stripe::Address.new(line1: "123 Street", city: "Nowhereville", state: "TX", postal_code: "98756"),
        phone: "111-2222",
      ),
      individual: Stripe::Account::Individual.new(
        first_name: "John",
        last_name: "Doe",
        address: Stripe::Address.new(line1: "123 Street", city: "Nowhereville", state: "TX", postal_code: "98756"),
        phone: "111-2222",
        email: "johhnydoe@example.com",
      ),
      tos_acceptance: Stripe::Account::TOSAcceptance.new(
        date: Time.local,
        ip: "127.0.0.1",
        user_agent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3018",
      )
    )
    account.id.should eq("acct_7772D82eZvKYlo2C")
  end
end
