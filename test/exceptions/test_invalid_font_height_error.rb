# frozen_string_literal: true

require_relative '../testing_prerequisites'

class TestInvalidFontHeightError < Minitest::Test
  def test_that_invalid_font_height_error_is_defined
    invalid_font_height_error_defined = defined?(AsciiPngfy::Exceptions::InvalidFontHeightError)

    refute_nil(invalid_font_height_error_defined)
  end

  def test_that_invalid_font_height_error_is_subclass_of_ascii_pngfy_error
    ascii_pngfy_error = AsciiPngfy::Exceptions::AsciiPngfyError
    invalid_font_height_error = AsciiPngfy::Exceptions::InvalidFontHeightError
    subclass_of_ascii_pngfy_error = (invalid_font_height_error < ascii_pngfy_error)

    assert(subclass_of_ascii_pngfy_error)
  end
end
