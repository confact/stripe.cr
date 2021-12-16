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

    {event.type, event.data.object.is_a?(Stripe::Product), event.data.previous_attributes}.should eq({"product.updated", true, {"metadata" => {"tier" => nil}, "updated" => 1620930329}})
  end
  it "construct_event for a checkout session" do
    timestamp = Time.utc
    payload = File.read("spec/support/event_checkout_session.json")
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

    {event.type, event.data.object.is_a?(Stripe::Checkout::Session), event.request.not_nil!.id}.should eq({"checkout.session.completed", true, "req_cILsoLL5w184zR"})
  end
  it "Raises on wrong secret" do
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
    expect_raises(Stripe::SignatureVerificationError) do
      Stripe::Webhook.construct_event(payload, header, "wrong_secret")
    end
  end
  it "Raises on old timestamp" do
    timestamp = Time.utc - 500.seconds
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
    expect_raises(Stripe::SignatureVerificationError) do
      Stripe::Webhook.construct_event(payload, header, secret)
    end
  end
end
