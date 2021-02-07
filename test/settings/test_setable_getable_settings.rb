# frozen_string_literal: true

require 'testing_prerequisites'

class TestSetableGetableSettings < Minitest::Test
  attr_reader(:settings)

  def setup
    @settings = AsciiPngfy::Settings::SetableGetableSettings.new
  end

  def test_that_setable_getable_settings_is_defined
    renderer_settings_defined = defined?(AsciiPngfy::Settings::SetableGetableSettings)

    refute_nil(renderer_settings_defined)
  end

  def test_that_setable_getable_settings_can_be_instantiated
    getable_setable_settings = AsciiPngfy::Settings::SetableGetableSettings.new

    assert_instance_of(AsciiPngfy::Settings::SetableGetableSettings, getable_setable_settings)
  end

  def test_that_setable_getable_settings_initializes_default_font_color_to_white
    default_font_color = settings.font_color

    assert_equal(255, default_font_color.red,   'Red component should be 255 for white')
    assert_equal(255, default_font_color.green, 'Green component should be 255 for white')
    assert_equal(255, default_font_color.blue,  'Blue component should be 255 for white')
    assert_equal(255, default_font_color.alpha, 'Alpha component should be 255 for opaque')
  end

  def test_that_setable_getable_settings_initializes_default_background_color_to_black
    default_background_color = settings.background_color

    assert_equal(0, default_background_color.red,   'Red component should be 0 for black')
    assert_equal(0, default_background_color.green, 'Green component should be 0 for black')
    assert_equal(0, default_background_color.blue,  'Blue component should be 0 for black')
    assert_equal(255, default_background_color.alpha, 'Alpha component should be 255 for opaque')
  end

  def test_that_setable_getable_settings_initializes_default_font_height_to_nine
    default_font_height = settings.font_height

    assert_equal(9, default_font_height)
  end

  def test_that_setable_getable_settings_initializes_default_horizontal_spacing_to_one
    default_horizontal_spacing = settings.horizontal_spacing

    assert_equal(1, default_horizontal_spacing)
  end

  def test_that_setable_getable_settings_initializes_default_vertical_spacing_to_one
    default_vertical_spacing = settings.vertical_spacing

    assert_equal(1, default_vertical_spacing)
  end

  def test_that_setable_getable_settings_initializes_text_to_non_empty_string
    default_text = settings.text

    assert_equal('<3 Ascii-Pngfy <3', default_text)
  end

  def test_that_setable_getable_settings_font_color_can_be_set
    settings.set_font_color(red: 50, green: 100, blue: 150, alpha: 200)

    assert_equal(AsciiPngfy::ColorRGBA.new(50, 100, 150, 200), settings.font_color)
  end

  def test_that_setable_getable_settings_background_color_can_be_set
    settings.set_background_color(red: 125, green: 25, blue: 75, alpha: 225)

    assert_equal(AsciiPngfy::ColorRGBA.new(125, 25, 75, 225), settings.background_color)
  end

  def test_that_setable_getable_settings_font_height_can_be_set
    expected_font_height = 9 * 15

    settings.set_font_height(expected_font_height)

    assert_equal(expected_font_height, settings.font_height)
  end

  def test_that_setable_getable_settings_horizontal_spacing_can_be_set
    expected_horizontal_spacing = 13

    settings.set_horizontal_spacing(expected_horizontal_spacing)

    assert_equal(expected_horizontal_spacing, settings.horizontal_spacing)
  end

  def test_that_setable_getable_settings_vertical_spacing_can_be_set
    expected_vertical_spacing = 21

    settings.set_vertical_spacing(expected_vertical_spacing)

    assert_equal(expected_vertical_spacing, settings.vertical_spacing)
  end

  def test_that_setable_getable_settings_text_can_be_set
    expected_text = 'I am the most valid ASCII text around!'

    settings.set_text(expected_text)

    assert_equal(expected_text, settings.text)
  end
end
