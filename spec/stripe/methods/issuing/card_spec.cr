require "../../../spec_helper"

describe Stripe::Issuing::Card do
  it "create card" do
    WebMock.stub(:post, "https://api.stripe.com/v1/issuing/cards")
      .to_return(status: 200, body: File.read("spec/support/create_card.json"), headers: {"Content-Type" => "application/json"})

    card = Stripe::Issuing::Card.create(
      cardholder: "ich_1MlyDKAxmG8F6OKs88GEi3K3",
      currency: "usd",
      type: "virtual",
    )
    card.id.should eq("ic_1LfRCcAxmG8F6OKs45gKnnNe")
  end

  it "retrieve card" do
    WebMock.stub(:get, "https://api.stripe.com/v1/issuing/cards/ic_1LfRCcAxmG8F6OKs45gKnnNe")
      .to_return(status: 200, body: File.read("spec/support/retrieve_card.json"), headers: {"Content-Type" => "application/json"})

    card = Stripe::Issuing::Card.retrieve(
      "ic_1LfRCcAxmG8F6OKs45gKnnNe",
    )
    card.id.should eq("ic_1LfRCcAxmG8F6OKs45gKnnNe")
    card.brand.should eq("Visa")
  end

  it "update card" do
    WebMock.stub(:post, "https://api.stripe.com/v1/issuing/cards/ic_1LfRCcAxmG8F6OKs45gKnnNe")
      .to_return(status: 200, body: File.read("spec/support/update_card.json"), headers: {"Content-Type" => "application/json"})

    card = Stripe::Issuing::Card.update(
      "ic_1LfRCcAxmG8F6OKs45gKnnNe",
      metadata: {order_id: "6735"},
    )

    card.metadata["order_id"].should eq("6735")
  end
end
