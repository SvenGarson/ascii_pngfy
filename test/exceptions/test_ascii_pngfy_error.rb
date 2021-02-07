# frozen_string_literal: true

require 'testing_prerequisites'

class TestAsciiPngfyError < Minitest::Test
  def test_that_ascii_pngfy_error_is_defined
    ascii_pngfy_error_defined = defined?(AsciiPngfy::Exceptions::AsciiPngfyError)

    refute_nil(ascii_pngfy_error_defined)
  end

  def test_that_ascii_pngfy_error_is_subclass_of_standard_error
    subclass_of_standard_error = (AsciiPngfy::Exceptions::AsciiPngfyError < StandardError)

    assert(subclass_of_standard_error)
  end
end
