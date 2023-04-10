require "../../../spec_helper"

describe Stripe::Issuing::Cardholder do
  it "create cardholder" do
    WebMock.stub(:post, "https://api.stripe.com/v1/issuing/cardholders")
      .to_return(status: 200, body: File.read("spec/support/create_cardholder.json"), headers: {"Content-Type" => "application/json"})

    cardholder = Stripe::Issuing::Cardholder.create(
      type: "individual",
      name: "Jenny Rosen",
      email: "jenny.rosen@example.com",
      phone_number: "+18888675309",
      billing: {
        address: {
          line1:       "1234 Main Street",
          city:        "San Francisco",
          state:       "CA",
          country:     "US",
          postal_code: "94111",
        },
      },
    )

    cardholder.id.should eq("ich_1MlvlEAxmG8F6OKsfTUZ00Co")
  end

  it "update cardholder" do
    WebMock.stub(:post, "https://api.stripe.com/v1/issuing/cardholders/ich_1MlvlEAxmG8F6OKsfTUZ00Co")
      .to_return(status: 200, body: File.read("spec/support/update_cardholder.json"), headers: {"Content-Type" => "application/json"})

    cardholder = Stripe::Issuing::Cardholder.update("ich_1MlvlEAxmG8F6OKsfTUZ00Co", email: "bmichelin@exemple.tech")
    cardholder.email.should eq("bmichelin@exemple.tech")
  end
end
