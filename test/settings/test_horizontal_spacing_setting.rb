# frozen_string_literal: true

require_relative '../testing_prerequisites'

class TestHorizontalSpacingSetting < Minitest::Test
  def test_that_horizontal_spacing_setting_set_returns_horizontal_spacing_which_reflects_the_new_internal_spacing
    horizontal_spacing_setting = AsciiPngfy::Settings::HorizontalSpacingSetting.new(3)
    expected_horizontal_spacing = 7

    returned_horizontal_spacing = horizontal_spacing_setting.set(7)

    assert_equal(expected_horizontal_spacing, returned_horizontal_spacing)
  end

  def test_that_horizontal_spacing_setting_get_returns_horizontal_spacing_which_reflects_the_last_horizontal_spacing_set
    horizontal_spacing_setting = AsciiPngfy::Settings::HorizontalSpacingSetting.new(5)
    horizontal_spacing_setting.set(11)
    expected_horizontal_spacing = 11

    returned_horizontal_spacing = horizontal_spacing_setting.get

    assert_equal(expected_horizontal_spacing, returned_horizontal_spacing)
  end
end
