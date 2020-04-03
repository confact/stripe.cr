require "../../spec_helper"

describe Stripe::Product do
  it "create product" do
    WebMock.stub(:post, "https://api.stripe.com/v1/products")
      .to_return(status: 200, body: File.read("spec/support/create_product.json"), headers: {"Content-Type" => "application/json"})

    product = Stripe::Product.create(name: "test plan")
    product.id.should eq("prod_H01khqrDN7Hn1R")
  end
end
