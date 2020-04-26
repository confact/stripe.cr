require "../../spec_helper"

describe Stripe::Plan do
  it "create plan" do
    WebMock.stub(:post, "https://api.stripe.com/v1/plans")
      .to_return(status: 200, body: File.read("spec/support/create_plan.json"), headers: {"Content-Type" => "application/json"})

    plan = Stripe::Plan.create(amount: 200, currency: "usd", interval: "month", id: "gold", product: "asdadssad")
    plan.id.should eq("gold")
  end
end
