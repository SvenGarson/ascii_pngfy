# frozen_string_literal: true

require 'testing_prerequisites'

class TestFontHeightSetting < Minitest::Test
  def test_that_font_height_setting_set_returns_font_height_which_reflects_the_new_internal_font_height
    font_height_setting = AsciiPngfy::Settings::FontHeightSetting.new(9)
    expected_returned_font_height = 27

    returned_font_height = font_height_setting.set(27)

    assert_equal(expected_returned_font_height, returned_font_height)
  end

  def test_that_font_height_setting_get_returns_font_height_which_reflects_the_last_font_height_set
    font_height_setting = AsciiPngfy::Settings::FontHeightSetting.new(87)
    font_height_setting.set(99)
    expected_returned_font_height = 99

    returned_font_height = font_height_setting.get

    assert_equal(expected_returned_font_height, returned_font_height)
  end
end
