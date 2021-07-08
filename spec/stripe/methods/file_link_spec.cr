require "../../spec_helper"

describe Stripe::FileLink do
  it "retrieve file link" do
    WebMock.stub(:get, "https://api.stripe.com/v1/file_links/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_file_link.json"), headers: {"Content-Type" => "application/json"})

    file_link = Stripe::FileLink.retrieve("asddad")
    file_link.id.should eq("link_1JAsjp2eZvKYlo2CeZn6v34e")
  end
end
