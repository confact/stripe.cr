require "../../spec_helper"

describe Stripe::Checkout::Session do
  it "create checkout session" do
    WebMock.stub(:post, "https://api.stripe.com/v1/checkout/sessions")
      .to_return(status: 200, body: File.read("spec/support/create_checkout_session.json"), headers: {"Content-Type" => "application/json"})

    checkout_session = Stripe::Checkout::Session.create(mode: "payment", payment_method_types: ["card"], cancel_url: "https://test.com", success_url: "https://test.com", line_items: [{quantity: 1, price: "price_1234awioejawef"}])
    checkout_session.id.should eq("cs_test_UlX36aKH1SdPk4Mtwp9z5S3Lkr7aIhbFbyQaCWev0aqX7mdmElg32LGr")
  end

  it "retrieve checkout session" do
    WebMock.stub(:get, "https://api.stripe.com/v1/checkout/sessions/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_checkout_session.json"), headers: {"Content-Type" => "application/json"})

    checkout_session = Stripe::Checkout::Session.retrieve("asddad")
    checkout_session.id.should eq("cs_test_Kkhdy5G3NRigIiMZr198DxpXUxirwrM1xFqGEt5zk5PH3AzDy7krza7g")
  end

  it "listing checkout sessions" do
    WebMock.stub(:get, "https://api.stripe.com/v1/checkout/sessions")
      .to_return(status: 200, body: File.read("spec/support/list_checkout_sessions.json"), headers: {"Content-Type" => "application/json"})

    checkout_sessions = Stripe::Checkout::Session.list
    checkout_sessions.first.id.should eq("cs_test_Kkhdy5G3NRigIiMZr198DxpXUxirwrM1xFqGEt5zk5PH3AzDy7krza7g")
  end
end
