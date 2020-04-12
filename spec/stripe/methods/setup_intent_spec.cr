require "../../spec_helper"

describe Stripe::SetupIntent do
  it "create setup intent" do
    WebMock.stub(:post, "https://api.stripe.com/v1/setup_intents")
      .to_return(status: 200, body: File.read("spec/support/create_setup_intent.json"), headers: {"Content-Type" => "application/json"})

    intent = Stripe::SetupIntent.create

    intent.id.should eq("seti_1GSdvVIfhoELGSZwebOwTZO1")
  end

  it "retrieve setup intent" do
    WebMock.stub(:get, "https://api.stripe.com/v1/setup_intents/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_setup_intent.json"), headers: {"Content-Type" => "application/json"})

    intent = Stripe::SetupIntent.retrieve("asddad")
    intent.id.should eq("seti_123456789")
  end

  it "listing setup intent" do
    WebMock.stub(:get, "https://api.stripe.com/v1/setup_intents")
      .to_return(status: 200, body: File.read("spec/support/list_setup_intents.json"), headers: {"Content-Type" => "application/json"})

    intents = Stripe::SetupIntent.list
    intents.first.id.should eq("seti_123456789")
  end

  it "confirm setup intent" do
    WebMock.stub(:post, "https://api.stripe.com/v1/setup_intents/asdad/confirm")
      .to_return(status: 200, body: File.read("spec/support/confirm_setup_intent.json"), headers: {"Content-Type" => "application/json"})

    intent = Stripe::SetupIntent.confirm("asdad", payment_method: "pm_card_visa")
    intent.id.should eq("seti_123456789")
    intent.status.should eq(Stripe::SetupIntent::Status::RequiresPaymentMethod)
  end
end
