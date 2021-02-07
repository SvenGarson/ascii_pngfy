# frozen_string_literal: true

require 'testing_prerequisites'

class TestInvalidSpacingError < Minitest::Test
  def test_that_invalid_spacing_error_is_defined
    invalid_spacing_error_defined = defined?(AsciiPngfy::Exceptions::InvalidSpacingError)

    refute_nil(invalid_spacing_error_defined)
  end

  def test_that_invalid_spacing_error_is_subclass_of_ascii_pngfy_error
    ascii_pngfy_error = AsciiPngfy::Exceptions::AsciiPngfyError
    invalid_spacing_error = AsciiPngfy::Exceptions::InvalidSpacingError
    subclass_of_ascii_pngfy_error = (invalid_spacing_error < ascii_pngfy_error)

    assert(subclass_of_ascii_pngfy_error)
  end
end
