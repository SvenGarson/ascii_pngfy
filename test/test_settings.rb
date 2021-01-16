# frozen_string_literal: true

require_relative 'testing_prerequisites'

class TestSettings < Minitest::Test
  def test_that_settings_is_defined
    settings_defined = defined?(AsciiPngfy::Settings)

    refute_nil(settings_defined)
  end
end
