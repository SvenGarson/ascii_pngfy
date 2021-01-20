# frozen_string_literal: true

require_relative '../testing_prerequisites'

class TestColorSetting < Minitest::Test
  def test_that_color_setting_set_returns_color_rgba_instance_where_color_components_reflect_the_new_internal_color
    color_setting = AsciiPngfy::Settings::ColorSetting.new(0, 0, 0, 0)
    expected_returned_color = AsciiPngfy::ColorRGBA.new(50, 100, 150, 250)

    returned_color = color_setting.set(red: 50, green: 100, blue: 150, alpha: 250)

    assert_equal(expected_returned_color, returned_color)
  end

  def test_that_color_settings_set_returns_color_rgba_instance_that_cannot_be_used_to_mutate_internal_state
    color_setting = AsciiPngfy::Settings::ColorSetting.new(15, 30, 45, 60)
    mutative_color = AsciiPngfy::ColorRGBA.new(101, 102, 103, 104)

    returned_color = color_setting.set(red: 50, green: 100, blue: 150, alpha: 250)

    # we want to make sure that the user cannot use the returned reference to change the internal color settings
    # by using the ColorRGBA methods directly
    returned_color.red = mutative_color.red
    returned_color.green = mutative_color.green
    returned_color.blue = mutative_color.blue
    returned_color.alpha = mutative_color.alpha

    current_internal_color = color_setting.set

    refute_equal(mutative_color, current_internal_color)
  end

  def test_that_color_setting_get_returns_color_rgba_instance_where_color_components_reflect_the_last_color_set
    color_setting = AsciiPngfy::Settings::ColorSetting.new(0, 0, 0, 0)
    color_setting.set(red: 40, green: 80, blue: 120, alpha: 160)
    expected_returned_color = AsciiPngfy::ColorRGBA.new(40, 80, 120, 160)

    returned_color = color_setting.get

    assert_equal(expected_returned_color, returned_color)
  end

  def test_that_color_settings_get_returns_color_rgba_instance_that_cannot_be_used_to_mutate_internal_state
    color_setting = AsciiPngfy::Settings::ColorSetting.new(10, 20, 30, 40)
    color_setting.set(red: 8, green: 16, blue: 24, alpha: 32)
    mutative_color = AsciiPngfy::ColorRGBA.new(215, 220, 225, 230)

    returned_color = color_setting.get

    # we want to make sure that the user cannot use the returned reference to change the internal color settings
    # by using the ColorRGBA methods directly
    returned_color.red = mutative_color.red
    returned_color.green = mutative_color.green
    returned_color.blue = mutative_color.blue
    returned_color.alpha = mutative_color.alpha

    current_internal_color = color_setting.get

    refute_equal(mutative_color, current_internal_color)
  end
end
