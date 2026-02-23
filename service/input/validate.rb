class Input::Validate
  INPUT_REGEX = /^(\d+)(?:\s+)(?:(imported)(?:\s+))?(.+)(?:\s+)(?:at)(?:\s+)(\d+(?:(?:\.|\,){1}(?:\d{2}))?)$/i

  def self.call(input)
    INPUT_REGEX.match?(input)
  end
end
