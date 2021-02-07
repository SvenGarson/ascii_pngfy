# frozen_string_literal: true

require 'testing_prerequisites'

class TestInvalidVerticalSpacingError < Minitest::Test
  def test_that_invalid_vertical_spacing_error_is_defined
    invalid_vertical_spacing_error_defined = defined?(AsciiPngfy::Exceptions::InvalidVerticalSpacingError)

    refute_nil(invalid_vertical_spacing_error_defined)
  end

  def test_that_invalid_vertical_spacing_error_is_subclass_of_invalid_spacing_error
    invalid_spacing_error = AsciiPngfy::Exceptions::InvalidSpacingError
    invalid_vertical_spacing_error = AsciiPngfy::Exceptions::InvalidVerticalSpacingError
    subclass_of_invalid_spacing_error = (invalid_vertical_spacing_error < invalid_spacing_error)

    assert(subclass_of_invalid_spacing_error)
  end
end
