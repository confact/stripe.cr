class Stripe::Error < Exception
  enum Type
    ApiConnectionError
    ApiError
    AuthenticationError
    CardError
    IdempotencyError
    InvalidRequestError
    RateLimitError
  end

  JSON.mapping({
    type: {
      type:      Type,
      converter: Enum::StringConverter(Type),
    },
    charge:       String?,
    code:         String?,
    decline_code: String?,
    doc_url:      String?,
    message:      String?,
    param:        String?,
    # source:       Source?, # TODO
  })
end
