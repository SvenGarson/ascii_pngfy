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
    assert_equal(255, default_font_color.alpha, 'Alpha component should be 255 for opaque')
  end

  def test_that_renderer_settings_initializes_default_background_color_to_black
    renderer_settings = AsciiPngfy::RendererSettings.new

    default_background_color = renderer_settings.background_color

    assert_equal(0, default_background_color.red,   'Red component should be 0 for black')
    assert_equal(0, default_background_color.green, 'Green component should be 0 for black')
    assert_equal(0, default_background_color.blue,  'Blue component should be 0 for black')
    assert_equal(255, default_background_color.alpha, 'Alpha component should be 255 for opaque')
  end

  def test_that_renderer_settings_initializes_default_font_height_to_nine
    renderer_settings = AsciiPngfy::RendererSettings.new

    default_font_height = renderer_settings.font_height

    assert_equal(9, default_font_height)
  end

  def test_that_renderer_settings_initializes_default_horizontal_spacing_to_one
    renderer_settings = AsciiPngfy::RendererSettings.new

    default_horizontal_spacing = renderer_settings.horizontal_spacing

    assert_equal(1, default_horizontal_spacing)
  end

  def test_that_renderer_settings_initializes_default_vertical_spacing_to_one
    renderer_settings = AsciiPngfy::RendererSettings.new

    default_vertical_spacing = renderer_settings.vertical_spacing

    assert_equal(1, default_vertical_spacing)
  end

  def test_that_renderer_settings_font_color_can_be_set
    renderer_settings = AsciiPngfy::RendererSettings.new

    renderer_settings.font_color = AsciiPngfy::ColorRGBA.new(50, 100, 150, 200)

    assert_equal(AsciiPngfy::ColorRGBA.new(50, 100, 150, 200), renderer_settings.font_color)
  end

  def test_that_renderer_settings_background_color_can_be_set
    renderer_settings = AsciiPngfy::RendererSettings.new

    renderer_settings.background_color = AsciiPngfy::ColorRGBA.new(125, 25, 75, 225)

    assert_equal(AsciiPngfy::ColorRGBA.new(125, 25, 75, 225), renderer_settings.background_color)
  end

  def test_that_renderer_settings_font_height_can_be_set
    renderer_settings = AsciiPngfy::RendererSettings.new

    renderer_settings.font_height = 79

    assert_equal(79, renderer_settings.font_height)
  end

  def test_that_renderer_settings_horizontal_spacing_can_be_set
    renderer_settings = AsciiPngfy::RendererSettings.new

    renderer_settings.horizontal_spacing = 13

    assert_equal(13, renderer_settings.horizontal_spacing)
  end

  def test_that_renderer_settings_vertical_spacing_can_be_set
    renderer_settings = AsciiPngfy::RendererSettings.new

    renderer_settings.vertical_spacing = 21

    assert_equal(21, renderer_settings.vertical_spacing)
  end
end
