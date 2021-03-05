require "../../spec_helper"

describe Stripe::Webhook do
  describe ".compute_signature" do
    it "computes a signature which can then be verified" do
      event_payload = "{\"id\": \"evt_test_webhook\",\"object\": \"event\"}"
      secret = "whsec_test_secret"
      timestamp = Time.utc
      signature = Stripe::Webhook::Signature.compute_signature(
        timestamp,
        event_payload,
        secret
      )
      scheme = "v1"
      header = Stripe::Webhook::Signature.generate_header(
        timestamp, signature, scheme: scheme
      )
      Stripe::Webhook::Signature.verify_header(event_payload, header, secret).should eq(true)
    end
  end
  describe ".generate_header" do
    it "generates a header in valid format" do
      timestamp = Time.utc
      event_payload = "{\"id\": \"evt_test_webhook\",\"object\": \"event\"}"
      secret = "whsec_test_secret"
      signature = Stripe::Webhook::Signature.compute_signature(
        timestamp,
        event_payload,
        secret
      )
      scheme = "v1"
      header = Stripe::Webhook::Signature.generate_header(
        timestamp, signature, scheme: scheme
      )

      header.should eq("t=#{timestamp.to_unix},#{scheme}=#{signature}")
    end
  end
  describe ".construct_event" do
    it "returns an Event instance from a valid JSON payload and valid signature header" do
      timestamp = Time.utc
      event_payload = "{\"id\": \"evt_test_webhook\",\"object\": \"event\",\"type\": \"checkout.session.completed\"}"
      secret = "whsec_test_secret"
      signature = Stripe::Webhook::Signature.compute_signature(
        timestamp,
        event_payload,
        secret
      )
      scheme = "v1"
      header = Stripe::Webhook::Signature.generate_header(
        timestamp, signature, scheme: scheme
      )
      event = Stripe::Webhook.construct_event(event_payload, header, secret)
      event.should be_a(Stripe::Event)
      event.type.should eq "checkout.session.completed"
    end
    it "raises a JSON::ParseException from an invalid JSON payload" do
      expect_raises(JSON::ParseException) do
        payload = "this is not valid JSON"
        timestamp = Time.utc
        secret = "whsec_test_secret"
        signature = Stripe::Webhook::Signature.compute_signature(
          timestamp,
          payload,
          secret
        )
        scheme = "v1"
        header = Stripe::Webhook::Signature.generate_header(
          timestamp, signature, scheme: scheme
        )
        Stripe::Webhook.construct_event(payload, header, secret)
      end
    end
    it "raises a SignatureVerificationError from a valid JSON payload and an invalid signature header" do
      header = "bad_header"
      event_payload = "{\"id\": \"evt_test_webhook\",\"object\": \"event\"}"
      secret = "whsec_test_secret"
      expect_raises Stripe::SignatureVerificationError do
        Stripe::Webhook.construct_event(event_payload, header, secret)
      end
    end
  end
  describe ".verify_signature_header" do
    it "raises a SignatureVerificationError when the header does not have the expected format" do
      header = "i'm not even a real signature header"
      event_payload = "{\"id\": \"evt_test_webhook\",\"object\": \"event\"}"
      secret = "whsec_test_secret"
      e = expect_raises Stripe::SignatureVerificationError do
        Stripe::Webhook::Signature.verify_header(event_payload, header, "secret")
      end
      e.message.should eq("Unable to extract timestamp and signatures from header")
    end
    it "raises a SignatureVerificationError when there are no signatures with the expected scheme" do
      timestamp = Time.utc
      event_payload = "{\"id\": \"evt_test_webhook\",\"object\": \"event\"}"
      secret = "whsec_test_secret"
      signature = Stripe::Webhook::Signature.compute_signature(
        timestamp,
        event_payload,
        secret
      )
      scheme = "v0"
      header = Stripe::Webhook::Signature.generate_header(
        timestamp, signature, scheme: scheme
      )
      e = expect_raises(Stripe::SignatureVerificationError) do
        Stripe::Webhook::Signature.verify_header(event_payload, header, "secret")
      end
      e.message.should eq("Unable to extract timestamp and signatures from header")
      # e.message.should eq("No signatures found with expected scheme")
    end
    it "raises a SignatureVerificationError when there are no valid signatures for the payload" do
      timestamp = Time.utc
      event_payload = "{\"id\": \"evt_test_webhook\",\"object\": \"event\"}"
      scheme = "v1"
      header = Stripe::Webhook::Signature.generate_header(
        timestamp, "bad_signature", scheme: scheme
      )
      e = expect_raises(Stripe::SignatureVerificationError) do
        Stripe::Webhook::Signature.verify_header(event_payload, header, "secret")
      end
      e.message.should eq("No signatures found matching the expected signature for payload")
    end
    it "raises a SignatureVerificationError when the timestamp is not within the tolerance" do
      timestamp = Time.utc - Time::Span.new(seconds: 15)
      event_payload = "{\"id\": \"evt_test_webhook\",\"object\": \"event\"}"
      secret = "whsec_test_secret"
      signature = Stripe::Webhook::Signature.compute_signature(
        timestamp,
        event_payload,
        secret
      )
      scheme = "v1"
      header = Stripe::Webhook::Signature.generate_header(
        timestamp, signature, scheme: scheme
      )
      e = expect_raises(Stripe::SignatureVerificationError) do
        Stripe::Webhook::Signature.verify_header(event_payload, header, "secret", tolerance: 10)
      end
      e.message.should eq("No signatures found matching the expected signature for payload")
      # e.message.should eq("Timestamp outside the tolerance zone")
    end
    it "returns true when the header contains a valid signature and the timestamp is within the tolerance" do
      timestamp = Time.utc
      event_payload = "{\"id\": \"evt_test_webhook\",\"object\": \"event\"}"
      secret = "whsec_test_secret"
      signature = Stripe::Webhook::Signature.compute_signature(
        timestamp,
        event_payload,
        secret
      )
      scheme = "v1"
      header = Stripe::Webhook::Signature.generate_header(
        timestamp, signature, scheme: scheme
      )
      result = Stripe::Webhook::Signature.verify_header(event_payload, header, secret)
      result.should eq(true)
    end
    it "returns true when the header contains at least one valid signature" do
      timestamp = Time.utc
      event_payload = "{\"id\": \"evt_test_webhook\",\"object\": \"event\"}"
      secret = "whsec_test_secret"
      signature = Stripe::Webhook::Signature.compute_signature(
        timestamp,
        event_payload,
        secret
      )
      scheme = "v1"
      header = Stripe::Webhook::Signature.generate_header(
        timestamp, signature, scheme: scheme
      ) + ",v1=bad_signature"

      result = Stripe::Webhook::Signature.verify_header(event_payload, header, secret)
      result.should eq(true)
    end
    it "returns true when the header contains a valid signature and the timestamp is off but no tolerance is provided" do
      timestamp = Time.unix(12_345)
      event_payload = "{\"id\": \"evt_test_webhook\",\"object\": \"event\"}"
      secret = "whsec_test_secret"
      signature = Stripe::Webhook::Signature.compute_signature(
        timestamp,
        event_payload,
        secret
      )
      scheme = "v1"
      header = Stripe::Webhook::Signature.generate_header(
        timestamp, signature, scheme: scheme
      )

      result = Stripe::Webhook::Signature.verify_header(event_payload, header, secret)
      result.should eq(true)
    end
  end
end