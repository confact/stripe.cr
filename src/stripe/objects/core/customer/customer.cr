# https://stripe.com/docs/api/customers/object

@[EventPayload]
class Stripe::Customer
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method
  add_list_method(
    email : String? = nil,
    created : Hash(String, Int32)? = nil,
    limit : Int32? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  )
  add_delete_method

  class TaxInfo
    include JSON::Serializable

    enum Type
      Vat
    end

    getter tax_id : String
    getter type : Type
  end

  class TaxInfoVerification
    include JSON::Serializable

    enum Status
      Unverified
      Pending
      Verified
    end

    @[JSON::Field(converter: Enum::StringConverter(Stripe::Customer::TaxInfoVerification::Status))]
    getter status : Status
    getter verified_name : String?
  end

  getter id : String
  getter balance : Int32?

  getter deleted : Bool? = false

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?
  getter currency : String?
  getter default_source : String?
  getter delinquent : Bool?
  getter name : String?
  getter description : String?
  getter email : String?
  getter phone : String?
  getter invoice_prefix : String?
  getter livemode : Bool?
  getter metadata : Hash(String, String)?
  getter shipping : Shipping?
  getter sources : List(PaymentMethods::Card | PaymentMethods::BankAccount)?
  # getter subscriptions : List?
  getter tax_info : TaxInfo?
  getter tax_info_verification : TaxInfoVerification?
end
