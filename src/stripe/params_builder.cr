require "http/params"

class Stripe::ParamsBuilder < HTTP::Params::Builder
  def add(key, value : Array(String))
    value.each_with_index do |v, i|
      add("#{key}[#{i}]", v.to_s)
    end
  end

  def add(key, value : Array(Hash(K, V) | NamedTuple)) forall K, V
    value.each_with_index do |v, i|
      add("#{key}[#{i}]", v)
    end
  end

  def add(key, value : Number | Bool)
    add(key, value.to_s)
  end

  def add(key, value : Hash | NamedTuple, path : Array(String)? = nil)
    value.each do |k, v|
      if v.is_a?(Hash) || v.is_a?(NamedTuple)
        _path = path ? path.dup : [key.to_s]
        add(k, v, _path.push(k.to_s))
      elsif v.nil?
        # Skip nil values
      else
        if path
          _path = path.dup.push(k.to_s)
          _key = _path.first + _path[1..-1].join("") { |p| "[#{p}]" }
        else
          _key = "#{key}[#{k}]"
        end

        case v
        when Enum then add(_key, v.to_s.underscore)
        else
          add(_key, v)
        end
      end
    end

    self
  end
end
