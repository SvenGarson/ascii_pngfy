# frozen_string_literal: true

require_relative '../testing_prerequisites'

class TestTooManyTextLinesError < Minitest::Test
  def test_that_too_many_text_lines_error_is_defined
    too_many_text_lines_error_defined = defined?(AsciiPngfy::Exceptions::TooManyTextLinesError)

    refute_nil(too_many_text_lines_error_defined)
  end

  def test_that_too_many_text_lines_error_is_subclass_of_ascii_pngfy_error
    ascii_pngfy_error = AsciiPngfy::Exceptions::AsciiPngfyError
    too_many_text_lines_error = AsciiPngfy::Exceptions::TooManyTextLinesError
    subclass_of_ascii_pngfy_error = (too_many_text_lines_error < ascii_pngfy_error)

    assert(subclass_of_ascii_pngfy_error)
  end
end
