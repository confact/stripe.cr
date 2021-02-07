class Stripe::Error < Exception
  include JSON::Serializable

  enum Type
    ApiConnectionError
    ApiError
    AuthenticationError
    CardError
    IdempotencyError
    InvalidRequestError
    RateLimitError
  end

  @[JSON::Field(converter: Enum::StringConverter(Stripe::Error::Type))]
  property type : Stripe::Error::Type
  property charge : String?
  property code : String?
  property decline_code : String?
  property doc_url : String?
  property message : String?
  property param : String?
end
