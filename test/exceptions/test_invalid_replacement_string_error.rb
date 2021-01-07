# frozen_string_literal: true

require_relative '../testing_prerequisites'

class TestInvalidReplacementTextError < Minitest::Test
  def test_that_invalid_replacement_text_error_is_defined
    invalid_replacement_text_error_defined = defined?(AsciiPngfy::Exceptions::InvalidReplacementTextError)

    refute_nil(invalid_replacement_text_error_defined)
  end

  def test_that_invalid_replacement_text_error_is_subclass_of_ascii_pngfy_error
    ascii_pngfy_error = AsciiPngfy::Exceptions::AsciiPngfyError
    invalid_replacement_text_error = AsciiPngfy::Exceptions::InvalidReplacementTextError
    subclass_of_ascii_pngfy_error = (invalid_replacement_text_error < ascii_pngfy_error)

    assert(subclass_of_ascii_pngfy_error)
  end
end
