# frozen_string_literal: true

require_relative '../testing_prerequisites'

class TestInvalidRGBAColorValueError < Minitest::Test
  def test_that_invalid_rgba_color_value_error_is_defined
    invalid_rgba_color_value_error_defined = defined?(AsciiPngfy::Exceptions::InvalidRGBAColorValueError)

    refute_nil(invalid_rgba_color_value_error_defined)
  end

  def test_that_invalid_rgba_color_value_error_is_subclass_of_ascii_pngfy_error
    ascii_pngfy_error = AsciiPngfy::Exceptions::AsciiPngfyError
    invalid_rgba_color_value_error = AsciiPngfy::Exceptions::InvalidRGBAColorValueError
    subclass_of_ascii_pngfy_error = (invalid_rgba_color_value_error < ascii_pngfy_error)

    assert(true, subclass_of_ascii_pngfy_error)
  end
end
