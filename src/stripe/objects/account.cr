# https://stripe.com/docs/api/accounts/object

@[EventPayload]
class Stripe::Account
  include JSON::Serializable
  include StripeMethods

  add_retrieve_method

  getter id : String

  enum BusinessType
    Individual
    Company
    NonProfit
    GovernmentEntity
  end

  getter business_type : BusinessType?

  class Capabilities
    include JSON::Serializable

    enum CapabilityValue
      Active
      Inactive
      Pending
    end

    getter acss_debit_payments : CapabilityValue?
    getter afterpay_clearpay_payments : CapabilityValue?
    getter au_becs_debit_payments : CapabilityValue?
    getter bacs_debit_payments : CapabilityValue?
    getter bancontact_payments : CapabilityValue?
    getter card_issuing : CapabilityValue?
    getter card_payments : CapabilityValue?
    getter cartes_bancaires_payments : CapabilityValue?
    getter eps_payments : CapabilityValue?
    getter fpx_payments : CapabilityValue?
    getter giropay_payments : CapabilityValue?
    getter grabpay_payments : CapabilityValue?
    getter ideal_payments : CapabilityValue?
    getter jcb_payments : CapabilityValue?
    getter legacy_payments : CapabilityValue?
    getter oxxo_payments : CapabilityValue?
    getter p24_payments : CapabilityValue?
    getter sepa_debit_payments : CapabilityValue?
    getter sofort_payments : CapabilityValue?
    getter tax_reporting_us_1099_k : CapabilityValue?
    getter tax_reporting_us_1099_misc : CapabilityValue?
    getter transfers : CapabilityValue?
  end

  getter capabilities : Capabilities?

  class Company
    include JSON::Serializable

    getter address : Stripe::Address?

    getter address_kana : Stripe::Address?

    getter address_kanji : Stripe::Address?

    getter directors_provided : Bool?
    getter executives_provided : Bool?

    getter name : String?
    getter name_kana : String?
    getter name_kanji : String?

    getter owners_provided : Bool?

    getter phone : String?

    enum Structure
      GovernmentInstrumentality
      GovernmentalUnit
      IncorporatedNonProfit
      LimitedLiabilityPartnership
      MultiMemberLlc
      PrivateCompany
      PrivateCorporation
      PrivatePartnership
      PublicCompany
      PublicCorporation
      PublicPartnership
      SingleMemberLlc
      SoleProprietorship
      TaxExemptGovernmentInstrumentality
      UnincorporatedAssociation
      UnincorporatedNonProfit
      FreeZoneLlc
      SoleEstablishment
      FreeZoneEstablishment
      Llc
    end

    getter structure : Structure?

    getter tax_id_provided : Bool?
    getter tax_id_registrar : String?
    getter vat_id_provided : Bool?

    class Verification
      include JSON::Serializable

      getter document : Document?

      class Document
        include JSON::Serializable

        getter back : String?
        getter details : String?

        enum DetailsCode
          DocumentCorrupt
          DocumentExpired
          DocumentFailedCopy
          DocumentFailedGreyscale
          DocumentFailedOther
          DocumentFailedTestMode
          DocumentFraudulent
          DocumentIncomplete
          DocumentInvalid
          DocumentManipulated
          DocumentNotReadable
          DocumentNotUploaded
          DocumentTypeNotSupported
          DocumentTooLarge
        end

        getter details_code : DetailsCode?

        getter back : String?
      end
    end

    getter verification : Verification?
  end

  getter country : String?
  getter email : String?

  class Individual
    include JSON::Serializable

    getter id : String
    getter object : String = "person"
    getter account : String?
    getter address : Stripe::Address?
    getter address_kana : Stripe::Address?
    getter address_kanji : Stripe::Address?
    @[JSON::Field(converter: Time::EpochConverter)]
    getter created : Time?

    class DateOfBirth
      include JSON::Serializable

      getter day : Int32
      getter month : Int32
      getter year : Int32
    end

    getter dob : DateOfBirth?
    getter email : String?
    getter first_name : String?
    getter first_name_kana : String?
    getter first_name_kanji : String?
    getter gender : String?
    getter id_number_provided : Bool?
    getter last_name : String?
    getter last_name_kana : String?
    getter last_name_kanji : String?
    getter maiden_name : String?
    getter metadata : JSON::Any?
    getter nationality : String?
    getter phone : String?

    enum PoliticalExposure
      Existing
      None
    end

    getter political_exposure : PoliticalExposure?

    class Relationship
      include JSON::Serializable
      getter director : Bool?
      getter executive : Bool?
      getter owner : Bool?
      getter percent_ownership : Float64?
      getter representative : Bool?
      getter title : String?
    end

    getter relationship : Relationship?

    class Requirements
      include JSON::Serializable
      @[JSON::Field(converter: Time::EpochConverter)]
      getter current_deadline : Time?
      getter currently_due : Array(String)?

      class Error
        include JSON::Serializable

        enum Code
          InvalidAddressCityStatePostalCode
          InvalidStreetAddress
          InvalidValueOther
          VerificationDocumentAddressMismatch
          VerificationDocumentAddressMissing
          VerificationDocumentCorrupt
          VerificationDocumentCountryNotSupported
          VerificationDocumentDobMismatch
          VerificationDocumentDuplicateType
          VerificationDocumentExpired
          VerificationDocumentFailedCopy
          VerificationDocumentFailedGreyscale
          VerificationDocumentFailedOther
          VerificationDocumentFailedTestMode
          VerificationDocumentFraudulent
          VerificationDocumentIdNumberMismatch
          VerificationDocumentIdNumberMissing
          VerificationDocumentIncomplete
          VerificationDocumentInvalid
          VerificationDocumentIssueOrExpiryDateMissing
          VerificationDocumentManipulated
          VerificationDocumentMissingBack
          VerificationDocumentMissingFront
          VerificationDocumentNameMismatch
          VerificationDocumentNameMissing
          VerificationDocumentNationalityMismatch
          VerificationDocumentNotReadable
          VerificationDocumentNotSigned
          VerificationDocumentNotUploaded
          VerificationDocumentPhotoMismatch
          VerificationDocumentTooLarge
          VerificationDocumentTypeNotSupported
          VerificationFailedAddressMatch
          VerificationFailedBusinessIecNumber
          VerificationFailedDocumentMatch
          VerificationFailedIdNumberMatch
          VerificationFailedKeyedIdentity
          VerificationFailedKeyedMatch
          VerificationFailedNameMatch
          VerificationFailedTaxIdMatch
          VerificationFailedTaxIdNotIssued
          VerificationFailedOther
          VerificationMissingOwners
          VerificationMissingExecutives
          VerificationRequiresAdditionalMemorandumOfAssociations
        end

        getter code : Code?
        getter reason : String?
        getter requirement : String?
      end

      getter errors : Array(Error?)

      getter eventually_due : Array(String)?

      getter past_due : Array(String)?
      getter pending_verification : Array(String)?
    end

    getter requirements : Requirements?
    getter ssn_last_4_provided : Bool?

    class Verification
      include JSON::Serializable

      getter additional_document : Company::Verification::Document?
      getter details : String?
      enum DetailsCode
        DocumentAddressMismatch
        DocumentDobMismatch
        DocumentDuplicateType
        DocumentIdNumberMismatch
        DocumentNameMismatch
        DocumentNationalityMismatch
        FailedKeyedIdentity
        FailedOther
      end
      getter details_code : DetailsCode?
      getter document : Company::Verification::Document?
    end

    getter verification : Verification?
  end

  getter individual : Individual?

  getter metadata : JSON::Any?

  getter requirements : Individual::Requirements?

  class TOSAcceptance
    include JSON::Serializable
    @[JSON::Field(converter: Time::EpochConverter)]
    getter date : Time?
    getter ip : String?
    getter service_agreement : String?
    getter user_agent : String?
  end

  getter tos_acceptance : TOSAcceptance?
  getter type : String?

  class BusinessProfile
    include JSON::Serializable
    getter mcc : String?
    getter name : String?
    getter product_description : String?
    getter support_address : Stripe::Address?
    getter support_email : String?
    getter support_phone : String?
    getter support_url : String?
    getter terms_of_service_url : String?
    getter url : String?
  end

  getter business_profile : BusinessProfile?
  getter charges_enabled : Bool?

  class Controller
    include JSON::Serializable

    getter is_controller : Bool?
    getter type : String?
  end

  getter controller : Controller?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?
  getter default_currency : String?
  getter details_submitted : Bool?
  getter external_accounts : List(Account)?
  getter payouts_enabled : Bool?

  class Settings
    include JSON::Serializable

    class BacsDebitPayments
      include JSON::Serializable
      getter display_name : String?
    end

    getter bacs_debit_payments : BacsDebitPayments?

    class Branding
      include JSON::Serializable
      getter icon : String? # expandable file_object
      getter logo : String? # expandable file_object
      getter primary_color : String?
      getter secondary_color : String?
    end

    getter branding : Branding?

    class CardIssuing
      include JSON::Serializable
      getter tos_acceptance : TOSAcceptance?
    end

    getter card_issuing : CardIssuing?

    class CardPayments
      include JSON::Serializable

      class DeclineOn
        include JSON::Serializable
        getter avs_failure : Bool?
        getter cvc_failure : Bool?
      end

      getter decline_on : DeclineOn?
      getter statement_descriptor_prefix : String?
    end

    getter card_payments : CardPayments?

    class Dashboard
      include JSON::Serializable
      getter display_name : String?
      getter timezone : String?
    end

    getter dashboard : Dashboard?

    class Payments
      include JSON::Serializable

      getter statement_descriptor : String?
      getter statement_descriptor_kana : String?
      getter statement_descriptor_kanji : String?
    end

    getter payments : Payments?

    class Payouts
      include JSON::Serializable

      getter debit_negative_balances : Bool?

      class Schedule
        include JSON::Serializable
        getter delay_days : Int32?
        getter interval : String?
        getter monthly_anchor : Int32?
        getter weekly_anchor : String?
      end

      getter schedule : Schedule?
      getter statement_descriptor : String?
    end

    getter payouts : Payouts?

    class SepaDebitPayments
      include JSON::Serializable
      getter creditor_id : String?
    end

    getter sepa_debit_payments : SepaDebitPayments?
  end

  getter settings : Settings?
end
