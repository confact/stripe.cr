module Stripe::Webhook::Signature
    EXPECTED_SCHEME = "v1"

    # Computes a webhook signature given a time (probably the current time),
    # a payload, and a signing secret.
    def self.compute_signature(timestamp : Time, payload : String, secret : String)
      timestamped_payload = "#{timestamp.to_unix}.#{payload}"

      OpenSSL::HMAC.hexdigest(
        OpenSSL::Algorithm::SHA256, secret, timestamped_payload
      )
    end

    # Generates a value that would be added to a `Stripe-Signature` for a
    # given webhook payload.
    #
    # Note that this isn't needed to verify webhooks in any way, and is
    # mainly here for use in test cases (those that are both within this
    # project and without).
    def self.generate_header(timestamp : Time, signature : String, scheme : String = EXPECTED_SCHEME)
      "t=#{timestamp.to_unix},#{scheme}=#{signature}"
    end

    # Extracts the timestamp and the signature(s) with the desired scheme
    # from the header
    def self.get_timestamp_and_signatures(header, scheme)
      list_items = header.split(/,\s*/).map { |i| i.split("=", 2) }
      timestamp = list_items.select { |i| i[0] == "t" }[0][1].to_s
      signatures = list_items.select { |i| i[0] == scheme }.map { |i| i[1] }[0]
      [timestamp, signatures]
    end

    def self.verify_header(payload, header, secret, tolerance = nil)
      begin
        timestamp, signatures =
          get_timestamp_and_signatures(header, EXPECTED_SCHEME)
      rescue Exception
        raise SignatureVerificationError.new(
          "Unable to extract timestamp and signatures from header",
          header
        )
      end

      #if signatures.empty?
      #  raise SignatureVerificationError.new("No signatures found with expected scheme #{EXPECTED_SCHEME}", header)
      #end

      timestamp = timestamp.to_i
      expected_sig = compute_signature(Time.unix(timestamp), payload, secret)
      unless secure_compare(expected_sig, signatures)
        raise SignatureVerificationError.new("No signatures found matching the expected signature for payload", header)
      end

      if tolerance && timestamp < Time.utc.to_unix - tolerance
          raise SignatureVerificationError.new(
            "Timestamp outside the tolerance zone (#{Time.unix(timestamp)})",
            header
          )
        end

      true
    end

    def self.secure_compare(a, b)
      return false unless a.bytesize == b.bytesize

      l = a.bytes

      res = 0
      b.each_byte { |byte| res |= byte ^ l.shift }
      res == 0
    end
  end