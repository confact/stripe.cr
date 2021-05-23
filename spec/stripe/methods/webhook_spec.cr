require "../../spec_helper"

describe Stripe::Webhook do
  it "construct_event" do
    timestamp = Time.utc
    payload = File.read("spec/support/event.json")
    secret = "secret"
    signature = Stripe::Webhook::Signature.compute_signature(
      timestamp,
      payload,
      secret
    )
    header = Stripe::Webhook::Signature.generate_header(
      timestamp,
      signature,
      scheme: "v1"
    )
    event = Stripe::Webhook.construct_event(payload, header, secret)
    event.type.should eq("product.updated")
  end
end
