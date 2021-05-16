require "../../spec_helper"

describe Stripe::Event do
  it "constructs event" do
    event = Stripe::Event.from_json(File.read("spec/support/event.json"))
    event.data.object.id.should eq("prod_JTgbc7dgwVuto4")
  end
end
