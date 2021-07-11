require "../../spec_helper"

describe Stripe::File do
  it "retrieve file" do
    WebMock.stub(:get, "https://api.stripe.com/v1/files/asddad")
      .to_return(status: 200, body: File.read("spec/support/retrieve_file.json"), headers: {"Content-Type" => "application/json"})

    file = Stripe::File.retrieve("asddad")
    file.id.should eq("file_19yVPO2eZvKYlo2CIrGjfyCO")
  end
end
