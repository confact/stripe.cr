struct Stripe::List(T)
  include JSON::Serializable

  getter data : Array(T)
  getter has_more : Bool
  getter total_count : Int32
  getter url : String
end
