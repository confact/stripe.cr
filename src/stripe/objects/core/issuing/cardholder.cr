class Stripe::Issuing::Cardholder
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method

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
