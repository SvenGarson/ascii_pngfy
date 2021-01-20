# frozen_string_literal: true

require_relative '../testing_prerequisites'

class TestTextLineTooLongError < Minitest::Test
  def test_that_text_line_too_long_error_is_defined
    text_line_too_long_error_defined = defined?(AsciiPngfy::Exceptions::TextLineTooLongError)

    refute_nil(text_line_too_long_error_defined)
  end

  def test_that_text_line_too_long_error_is_subclass_of_ascii_pngfy_error
    ascii_pngfy_error = AsciiPngfy::Exceptions::AsciiPngfyError
    text_line_too_long_error = AsciiPngfy::Exceptions::TextLineTooLongError
    subclass_of_ascii_pngfy_error = (text_line_too_long_error < ascii_pngfy_error)

    assert(subclass_of_ascii_pngfy_error)
  end
end
