# frozen_string_literal: true

require 'testing_prerequisites'

class TestInvalidCharacterError < Minitest::Test
  def test_that_invalid_character_error_is_defined
    invalid_character_error_defined = defined?(AsciiPngfy::Exceptions::InvalidCharacterError)

    refute_nil(invalid_character_error_defined)
  end

  def test_that_invalid_character_error_is_subclass_of_ascii_pngfy_error
    ascii_pngfy_error = AsciiPngfy::Exceptions::AsciiPngfyError
    invalid_character_error = AsciiPngfy::Exceptions::InvalidCharacterError
    subclass_of_ascii_pngfy_error = (invalid_character_error < ascii_pngfy_error)

    assert(subclass_of_ascii_pngfy_error)
  end
end
