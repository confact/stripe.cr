class Exception
  @[JSON::Field(ignore: true)]
  @cause : Exception?

  @[JSON::Field(ignore: true)]
  @callstack : Exception::CallStack?
end
