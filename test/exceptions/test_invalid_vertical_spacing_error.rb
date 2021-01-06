# frozen_string_literal: true

require_relative '../testing_prerequisites'

class TestInvalidVerticalSpacingError < Minitest::Test
  def test_that_invalid_vertical_spacing_error_is_defined
    invalid_vertical_spacing_error_defined = defined?(AsciiPngfy::Exceptions::InvalidVerticalSpacingError)

    refute_nil(invalid_vertical_spacing_error_defined)
  end

  def test_that_invalid_vertical_spacing_error_is_subclass_of_ascii_pngfy_error
    ascii_pngfy_error = AsciiPngfy::Exceptions::AsciiPngfyError
    invalid_vertical_spacing_error = AsciiPngfy::Exceptions::InvalidVerticalSpacingError
    subclass_of_ascii_pngfy_error = (invalid_vertical_spacing_error < ascii_pngfy_error)

    assert(subclass_of_ascii_pngfy_error)
  end
end
