# frozen_string_literal: true

require_relative '../testing_prerequisites'

class TestColorSetting < Minitest::Test
  # set
    # - no injection test - all immediate values
    # - return value is the new color set through arguments
    # - return value is duplicate - cannot be used to change the internal state
  # get
    # - no injection testing - no arguments
    # - return value is the color last set succesfully
    # - return value is duplicate - cannot be used to change the internal state

  def test_that_color_setting_set_returns_color_rgba_instance_where_color_components_reflect_the_new_internal_color
    color_setting = AsciiPngfy::Settings::ColorSetting.new(0, 0, 0, 0)
    expected_returned_color = AsciiPngfy::ColorRGBA.new(50, 100, 150, 250)

    returned_color = color_setting.set(red: 50, green: 100, blue: 150, alpha: 250)

    assert_equal(expected_returned_color, returned_color)
  end
end