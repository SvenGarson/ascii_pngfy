# frozen_string_literal: true

require_relative 'testing_prerequisites'

class TestRendererSettings < Minitest::Test
  def test_that_renderer_settings_is_defined
    renderer_settings_defined = defined?(AsciiPngfy::RendererSettings)

    refute_nil(renderer_settings_defined)
  end

  # test renderer settings instantiation
  # test renderer settings initialized with expected values
end
