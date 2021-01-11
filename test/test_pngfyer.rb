# frozen_string_literal: true

require_relative 'testing_prerequisites'

class TestPngfyer < Minitest::Test
  def test_that_pngfyer_is_defined
    pngfyer_defined = defined?(AsciiPngfy::Pngfyer)

    refute_nil(pngfyer_defined)
  end
end
