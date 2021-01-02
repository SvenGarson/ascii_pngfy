# frozen_string_literal: true

require_relative 'test_prerequisites'

class TestAsciiPngfy < Minitest::Test
  def test_that_ascii_pngfy_is_defined
    ascii_pngfy_defined = defined?(AsciiPngfy)

    refute_nil(ascii_pngfy_defined)
  end
end
