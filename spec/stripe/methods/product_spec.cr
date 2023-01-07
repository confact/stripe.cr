require "../../spec_helper"

describe Stripe::Product do
  it "create product" do
    WebMock.stub(:post, "https://api.stripe.com/v1/products")
      .to_return(status: 200, body: File.read("spec/support/create_product.json"), headers: {"Content-Type" => "application/json"})

    product = Stripe::Product.create(name: "test product")
    product.id.should eq("prod_H01khqrDN7Hn1R")
  end

  it "listing products" do
    WebMock.stub(:get, "https://api.stripe.com/v1/products")
      .to_return(status: 200, body: File.read("spec/support/list_products.json"), headers: {"Content-Type" => "application/json"})

    products = Stripe::Product.list
    products.first.id.should eq("prod_JTgbc7dgwVuto4")
  end
end
