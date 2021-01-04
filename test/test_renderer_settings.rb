# frozen_string_literal: true

require_relative 'testing_prerequisites'

class TestRendererSettings < Minitest::Test
  def test_that_renderer_settings_is_defined
    renderer_settings_defined = defined?(AsciiPngfy::RendererSettings)

    refute_nil(renderer_settings_defined)
  end

  def test_that_renderer_settings_can_be_instantiated
    renderer_settings = AsciiPngfy::RendererSettings.new

    assert_instance_of(AsciiPngfy::RendererSettings, renderer_settings)
  end

  def test_that_renderer_settings_initializes_default_font_color_to_white
    renderer_settings = AsciiPngfy::RendererSettings.new

    default_font_color = renderer_settings.font_color

    assert_equal(255, default_font_color.red,   'Red component should be 255 for white')
    assert_equal(255, default_font_color.green, 'Green component should be 255 for white')
    assert_equal(255, default_font_color.blue,  'Blue component should be 255 for white')
    assert_equal(255, default_font_color.alpha, 'Alpha component should be 255 for white')
  end

  # cannot mutate color externally!
end
