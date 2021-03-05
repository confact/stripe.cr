class Stripe
  module Webhook
    DEFAULT_TOLERANCE = 300

    # Initializes an Event object from a JSON payload.
    #
    # This may raise JSON::ParserError if the payload is not valid JSON, or
    # SignatureVerificationError if the signature verification fails.
    # @see https://github.com/stripe/stripe-ruby/blob/master/lib/stripe/webhook.rb
    def self.construct_event(
      payload,
      sig_header,
      secret,
      tolerance = DEFAULT_TOLERANCE
    )
      Signature.verify_header(payload, sig_header, secret, tolerance: tolerance)

      Event.construct_from(payload)
    end
  end
end
