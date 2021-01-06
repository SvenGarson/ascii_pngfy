# frozen_string_literal: true

require_relative '../testing_prerequisites'

class TestInvalidHorizontalSpacingError < Minitest::Test
  def test_that_invalid_horizontal_spacing_error_is_defined
    invalid_horizontal_spacing_error_defined = defined?(AsciiPngfy::Exceptions::InvalidHorizontalSpacingError)

    refute_nil(invalid_horizontal_spacing_error_defined)
  end

  def test_that_invalid_horizontal_spacing_error_is_subclass_of_ascii_pngfy_error
    ascii_pngfy_error = AsciiPngfy::Exceptions::AsciiPngfyError
    invalid_horizontal_spacing_error = AsciiPngfy::Exceptions::InvalidHorizontalSpacingError
    subclass_of_ascii_pngfy_error = (invalid_horizontal_spacing_error < ascii_pngfy_error)

    assert(subclass_of_ascii_pngfy_error)
  end
end
