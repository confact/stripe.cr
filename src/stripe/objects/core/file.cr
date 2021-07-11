# https://stripe.com/docs/api/files/object

class Stripe::File
  include JSON::Serializable

  enum Purpose
    AccountRequirement
    AdditionalVerification
    BusinessIcon
    BusinessLogo
    CustomerSignature
    DisputeEvidence
    DocumentProviderIdentityDocument
    FinanceReportRun
    IdentityDocument
    IdentityDocumentDownloadable
    PciDocument
    Selfie
    SigmaScheduledQuery
    TaxDocumentUserUpload
  end

  getter id : String
  getter type : String?

  @[JSON::Field(converter: Enum::StringConverter(Stripe::File::Purpose))]
  getter purpose : Purpose?
  getter object : String = "file"
  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time
  @[JSON::Field(converter: Time::EpochConverter)]
  getter expires_at : Time?
  getter filename : String?
  getter links : Stripe::List(FileLink)?
  getter size : Int32?
  getter title : String?
  getter url : String?
end
