# frozen_string_literal: true

require_relative '../testing_prerequisites'

class TestVerticalSpacingSetting < Minitest::Test
  def test_that_vertical_spacing_setting_set_returns_vertical_spacing_which_reflects_the_new_internal_spacing
    vertical_spacing_setting = AsciiPngfy::Settings::VerticalSpacingSetting.new(3)
    expected_vertical_spacing = 7

    returned_vertical_spacing = vertical_spacing_setting.set(7)

    assert_equal(expected_vertical_spacing, returned_vertical_spacing)
  end

  def test_that_vertical_spacing_setting_get_returns_vertical_spacing_which_reflects_the_last_vertical_spacing_set
    vertical_spacing_setting = AsciiPngfy::Settings::VerticalSpacingSetting.new(5)
    vertical_spacing_setting.set(11)
    expected_vertical_spacing = 11

    returned_vertical_spacing = vertical_spacing_setting.get

    assert_equal(expected_vertical_spacing, returned_vertical_spacing)
  end
end
