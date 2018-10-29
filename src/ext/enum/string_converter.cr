struct Enum
  class StringConverter(T)
    def self.from_json(value : JSON::PullParser) : T
      T.parse(value.read_string)
    end

    def self.to_json(value : self, json : JSON::Builder)
      json.string(value.to_s)
    end
  end
end
