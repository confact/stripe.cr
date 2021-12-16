# Adapted from https://github.com/stripe/stripe-ruby/blob/master/lib/stripe/webhook.rb

require "crypto/subtle"
require "openssl/hmac"

class Stripe::Webhook
  DEFAULT_TOLERANCE = 300

  # Initializes an Event object from a JSON payload.
  #
  # This may raise JSON::SerializableError if the payload is not valid JSON, or
  # SignatureVerificationError if the signature verification fails.
  def self.construct_event(payload : String, sig_header : String, secret : String,
                           tolerance : Int32? = DEFAULT_TOLERANCE)
    Signature.verify_header(payload: payload, header: sig_header, secret: secret, tolerance: tolerance)

    Stripe::Event.from_json(payload)
  end

  module Signature
    EXPECTED_SCHEME = "v1"

    # Computes a webhook signature given a time (probably the current time),
    # a payload, and a signing secret.
    def self.compute_signature(timestamp : Time, payload : String, secret : String) : String
      timestamped_payload = "#{timestamp.to_unix.to_i}.#{payload}"
      OpenSSL::HMAC.hexdigest(OpenSSL::Algorithm.new(:SHA256), secret,
        timestamped_payload)
    end

    # Generates a value that would be added to a `Stripe-Signature` for a
    # given webhook payload.
    #
    # Note that this isn't needed to verify webhooks in any way, and is
    # mainly here for use in test cases (those that are both within this
    # project and without).
    def self.generate_header(timestamp : Time, signature : String, scheme : String = EXPECTED_SCHEME) : String
      "t=#{timestamp.to_unix},#{scheme}=#{signature}"
    end

    # Extracts the timestamp and the signature(s) with the desired scheme
    # from the header
    private def self.get_timestamp_and_signatures(header : String, scheme : String) : Tuple(Time, Array(String))
      list_items = header.split(',').map(&.split("=", 2))
      timestamp = (list_items.select { |i| i[0] == "t" }[0][1]).to_i
      signatures = list_items.select { |i| i[0] == scheme }.map { |i| i[1] }
      {Time.unix(timestamp), signatures}
    end

    # Verifies the signature header for a given payload.
    #
    # Raises a SignatureVerificationError in the following cases:
    # - the header does not match the expected format
    # - no signatures found with the expected scheme
    # - no signatures matching the expected signature
    # - a tolerance is provided and the timestamp is not within the
    #   tolerance
    #
    # Returns true otherwise
    def self.verify_header(payload : String, header : String, secret : String, tolerance : Int32? = nil) : Bool
      begin
        timestamp = get_timestamp_and_signatures(header, EXPECTED_SCHEME).first.as(Time)
        signatures = get_timestamp_and_signatures(header, EXPECTED_SCHEME).last.as(Array(String))
      rescue
        raise SignatureVerificationError.new(
          message: "Unable to extract timestamp and signatures from header",
          header: header, param: payload
        )
      end

      if signatures.empty?
        raise SignatureVerificationError.new(
          message: "No signatures found with expected scheme #{EXPECTED_SCHEME}",
          header: header, param: payload
        )
      end

      expected_sig = compute_signature(timestamp: timestamp, payload: payload, secret: secret)
      unless signatures.any? { |s| Crypto::Subtle.constant_time_compare(expected_sig, s) }
        raise SignatureVerificationError.new(
          "No signatures found matching the expected signature for payload" + [expected_sig, signatures].to_s,
          header: header, param: payload
        )
      end

      if tolerance && timestamp.to_unix.to_i < Time.utc.to_unix.to_i - tolerance
        raise SignatureVerificationError.new(
          "Timestamp outside the tolerance zone (#{timestamp})",
          header: header, param: payload
        )
      end

      true
    end
  end
end

class Stripe::SignatureVerificationError < Exception
  include JSON::Serializable
  property message : String?
  property param : String?
  property header : String?

  def initialize(@message, @param, @header)
  end
end
