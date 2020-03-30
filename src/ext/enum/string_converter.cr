struct Enum
  class StringConverter(T)
    def self.from_json(value : JSON::PullParser) : T
      T.parse(value.read_string)
    end

    def self.to_json(value : T, json : JSON::Builder)
      json.string(value.to_s.underscore)
    end
  end
end
