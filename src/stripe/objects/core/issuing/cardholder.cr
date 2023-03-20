class Stripe::Issuing::Cardholder
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method

  add_create_method(
    billing : Hash(String, String) | NamedTuple | Billing,
    name : String,
    type : String,
    email : String? = nil,
    metadata : Hash(String, String) | NamedTuple? = nil,
    phone_number : String? = nil,
    company : Company? = nil,
    individual : Individual? = nil,
    spending_controls : Hash(String, Int32)? = nil,
    status : String? = nil,
  )

  add_update_method(
    billing : Hash? = nil,
    name : String? = nil,
    email : String? = nil,
    metadata : Hash(String, String)? = nil,
    phone_number : String? = nil,
    company : Hash? =nil,
    individual : Hash? =nil,
    spending_controls : Hash? =nil,
    status : String? = nil,
  )

  add_list_method(
    email : String? = nil,
    phone_number : String? = nil,
    status : String? = nil,
    type : String? = nil,
    created : Hash(String, Int32)? = nil,
    limit : Int32? = nil,
    starting_after : String? = nil,
    ending_before : String? = nil
  )

  enum Type
    Individual
    Company
  end

  struct Billing
    include JSON::Serializable

    struct Address
      include JSON::Serializable
      property city : String?
      property country : String?
      property line1 : String?
      property line2 : String?
      property postal_code : String?
      property state : String?
    end

    property address : Address?
  end

  struct Company
    include JSON::Serializable
    property tax_id_provided : Bool?
  end

  struct Individual
    include JSON::Serializable

    struct CardIssuing
      include JSON::Serializable

      struct UserTermsAcceptance
        include JSON::Serializable
        property date : Time?
        property ip : String?
        user_agent : String?
      end

      property user_terms_acceptance : Hash(String, String | Int32)?
    end

    property card_issuing : CardIssuing?
  end

  getter id : String
  getter billing : Billing?
  getter email : String?
  getter metadata : Hash(String, String)?
  getter name : String?
  getter phone_number : String?
  getter type : Type
  getter object = "issuing.cardholder"
  getter company : Company?
  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time
  getter individual : Individual?
  getter? livemode : Bool
  getter requirements : Hash(String, String | Array(String) | Nil)?
  getter spending_controls : Card::SpendingControls?
end
