require "../../spec_helper"

describe Stripe::Source do
  it "create source" do
    WebMock.stub(:post, "https://api.stripe.com/v1/sources")
      .to_return(status: 200, body: File.read("spec/support/create_source.json"), headers: {"Content-Type" => "application/json"})

    source = Stripe::Source.create(type: "ach_credit_transfer",
      currency: "usd",
      owner: {
        email: "jenny.rosen@example.com",
      })
    source.id.should eq("src_1GU6ZMIfhoELGSZwMRGuGNbX")
    source.owner.not_nil!.email.should eq("jenny.rosen@example.com")
  end

  it "retrieve source" do
    WebMock.stub(:get, "https://api.stripe.com/v1/sources/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_source.json"), headers: {"Content-Type" => "application/json"})

    source = Stripe::Source.retrieve("asddad")
    source.id.should eq("src_1GU6ZMIfhoELGSZwMRGuGNbX")
  end

  it "attach source to customer" do
    WebMock.stub(:post, "https://api.stripe.com/v1/customers/asadad/sources")
      .to_return(status: 200, body: File.read("spec/support/retrieve_source.json"), headers: {"Content-Type" => "application/json"})

    source = Stripe::Customer.create_source("asadad", source: "adasda")
    source.id.should eq("src_1GU6ZMIfhoELGSZwMRGuGNbX")
  end

  it "detach source from customer" do
    WebMock.stub(:delete, "https://api.stripe.com/v1/customers/asadad/sources/ddad")
      .to_return(status: 200, body: File.read("spec/support/detach_source.json"), headers: {"Content-Type" => "application/json"})

    source = Stripe::Customer.detach_source(customer: "asadad", source: "ddad")
    source.id.should eq("src_1GU6ZMIfhoELGSZwMRGuGNbX")
    source.status.should eq(Stripe::Source::Status::Consumed)
  end
end
