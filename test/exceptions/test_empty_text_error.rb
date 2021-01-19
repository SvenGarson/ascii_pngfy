# frozen_string_literal: true

require_relative '../testing_prerequisites'

class TestEmptyTextError < Minitest::Test
  def test_that_empty_text_error_is_defined
    empty_text_error_defined = defined?(AsciiPngfy::Exceptions::EmptyTextError)

    refute_nil(empty_text_error_defined)
  end

  def test_that_empty_text_error_is_subclass_of_ascii_pngfy_error
    ascii_pngfy_error = AsciiPngfy::Exceptions::AsciiPngfyError
    empty_text_error = AsciiPngfy::Exceptions::EmptyTextError
    subclass_of_ascii_pngfy_error = (empty_text_error < ascii_pngfy_error)

    assert(subclass_of_ascii_pngfy_error)
  end
end
