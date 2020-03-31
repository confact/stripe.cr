require "../spec_helper"

describe Stripe::ParamsBuilder do
  it "can handle strings" do
    io = IO::Memory.new
    builder = Stripe::ParamsBuilder.new(io)

    builder.add("test", "string")

    io.to_s.should eq("test=string")
  end

  it "can handle arrays" do
    io = IO::Memory.new
    builder = Stripe::ParamsBuilder.new(io)

    builder.add("test", ["string1", "string2"])

    io.to_s.should eq("test%5B0%5D=string1&test%5B1%5D=string2")
  end

  it "can handle hash" do
    io = IO::Memory.new
    builder = Stripe::ParamsBuilder.new(io)

    builder.add("test", {"test" => "test2"})

    io.to_s.should eq("test%5Btest%5D=test2")
  end

  it "can handle array with hash" do
    io = IO::Memory.new
    builder = Stripe::ParamsBuilder.new(io)

    builder.add("test", [{"test" => "test2"}, {"test22" => "test23"}])

    io.to_s.should eq("test%5B0%5D%5Btest%5D=test2&test%5B1%5D%5Btest22%5D=test23")
  end

  it "can handle array with NamedTuple" do
    data = [{
      number:    "4242424242424242",
      exp_month: 12,
      exp_year:  2019,
      cvc:       123,
    }, {
      number:    "4242424242424242",
      exp_month: 12,
      exp_year:  2019,
      cvc:       123,
    }]

    io = IO::Memory.new
    builder = Stripe::ParamsBuilder.new(io)

    builder.add("test", data)

    io.to_s.should eq("test%5B0%5D%5Bnumber%5D=4242424242424242&test%5B0%5D%5Bexp_month%5D=12&test%5B0%5D%5Bexp_year%5D=2019&test%5B0%5D%5Bcvc%5D=123&test%5B1%5D%5Bnumber%5D=4242424242424242&test%5B1%5D%5Bexp_month%5D=12&test%5B1%5D%5Bexp_year%5D=2019&test%5B1%5D%5Bcvc%5D=123")
  end
end
