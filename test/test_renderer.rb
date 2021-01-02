# frozen_string_literal: true

require_relative 'testing_prerequisites'

class TestRenderer < Minitest::Tes
  class TestRenderer < AsciiPngfy::Renderer
    # acts as exact replacement to renderer
    # but provides a getter for the settings instance
    # to spy on the attributes
  end

  def test_that_renderer_is_defined
    renderer_defined = defined?(AsciiPngfy::Renderer)

    refute_nil(renderer_defined)
  end

  def test_that_renderer_can_be_instantiated
    renderer = AsciiPngfy::Renderer.new

    assert_instance_of(AsciiPngfy::Renderer, renderer)
  end

  def test_that_renderer_initializes_with_expected_setting_values
    # renderer_settings = AsciiPngfy::RendererSettings
    # this is a job for the renderer settings itself
  end
end
