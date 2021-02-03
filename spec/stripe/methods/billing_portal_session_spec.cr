require "../../spec_helper"

describe Stripe::BillingPortal::Session do
  it "create billing portal session" do
    WebMock.stub(:post, "https://api.stripe.com/v1/billing_portal/sessions")
      .to_return(status: 200, body: File.read("spec/support/create_billing_portal_session.json"), headers: {"Content-Type" => "application/json"})

    billing_portal_session = Stripe::BillingPortal::Session.create(customer: "cus_Ie0yEXsGjNVKMT")

    billing_portal_session.id.should eq("bps_1I31kfBIZW9yg15I3FuLNDpj")
    billing_portal_session.url.should_not be_nil
  end
end
