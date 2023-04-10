require "../../spec_helper"

describe Stripe::Topup do
  it "create topup" do
    WebMock.stub(:post, "https://api.stripe.com/v1/topups")
      .to_return(status: 200, body: File.read("spec/support/create_topup.json"), headers: {"Content-Type" => "application/json"})

    topup = Stripe::Topup.create(
      amount: 2000,
      currency: "usd",
      description: "Top-up for Jenny Rosen",
      statement_descriptor: "Top-up",
    )
    topup.id.should eq("tu_1MlzdzAxmG8F6OKs3s9THxGZ")
  end

  it "retrieve topup" do
    WebMock.stub(:get, "https://api.stripe.com/v1/topups/tu_1MlykwAxmG8F6OKsQ6VVzqIi")
      .to_return(status: 200, body: File.read("spec/support/create_topup.json"), headers: {"Content-Type" => "application/json"})

    topup = Stripe::Topup.retrieve("tu_1MlykwAxmG8F6OKsQ6VVzqIi")
    topup.amount.should eq(2000)
  end

  it "update topup" do
    WebMock.stub(:post, "https://api.stripe.com/v1/topups/tu_1MlykwAxmG8F6OKsQ6VVzqIi")
      .to_return(status: 200, body: File.read("spec/support/update_topup.json"), headers: {"Content-Type" => "application/json"})

    topup = Stripe::Topup.update(
      "tu_1MlykwAxmG8F6OKsQ6VVzqIi",
      metadata: {"order_id" => "6735"},
    )
    topup.metadata["order_id"].should eq("6735")
  end

  it "cancel topup" do
    WebMock.stub(:post, "https://api.stripe.com/v1/topups/tu_1MlykwAxmG8F6OKsQ6VVzqIi/cancel")
      .to_return(status: 200, body: File.read("spec/support/cancel_topup.json"), headers: {"Content-Type" => "application/json"})

    topup = Stripe::Topup.cancel("tu_1MlykwAxmG8F6OKsQ6VVzqIi")
    topup.status.should eq("canceled")
  end
end
