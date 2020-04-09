class Stripe::List(T)
  include JSON::Serializable
  include Enumerable(T)

  getter data : Array(T)
  getter has_more : Bool
  getter total_count : Int32?
  getter url : String

  def each(&block)
    data.each do |i|
      yield i
    end
  end
end
