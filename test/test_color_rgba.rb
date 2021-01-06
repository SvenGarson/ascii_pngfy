# frozen_string_literal: true

require_relative 'testing_prerequisites'

# rubocop:disable Metrics/ClassLength
class TestColorRGBA < Minitest::Test
  def test_that_color_rgba_is_defined
    color_rgba_defined = defined?(AsciiPngfy::ColorRGBA)

    refute_nil(color_rgba_defined)
  end

  def test_that_color_rgba_red_component_initializes_as_expected
    rgba = AsciiPngfy::ColorRGBA.new(11, 22, 33, 44)

    red = rgba.red

    assert_equal(11, red)
  end

  def test_that_color_rgba_green_component_initializes_as_expected
    rgba = AsciiPngfy::ColorRGBA.new(11, 22, 33, 44)

    green = rgba.green

    assert_equal(22, green)
  end

  def test_that_color_rgba_blue_component_initializes_as_expected
    rgba = AsciiPngfy::ColorRGBA.new(11, 22, 33, 44)

    blue = rgba.blue

    assert_equal(33, blue)
  end

  def test_that_color_rgba_alpha_component_initializes_as_expected
    rgba = AsciiPngfy::ColorRGBA.new(11, 22, 33, 44)

    alpha = rgba.alpha

    assert_equal(44, alpha)
  end

  def test_that_color_rgba_red_component_can_be_set
    rgba = AsciiPngfy::ColorRGBA.new(0, 0, 0, 0)

    rgba.red = 50

    assert_equal(50, rgba.red)
  end

  def test_that_color_rgba_green_component_can_be_set
    rgba = AsciiPngfy::ColorRGBA.new(0, 0, 0, 0)

    rgba.green = 100

    assert_equal(100, rgba.green)
  end

  def test_that_color_rgba_blue_component_can_be_set
    rgba = AsciiPngfy::ColorRGBA.new(0, 0, 0, 0)

    rgba.blue = 150

    assert_equal(150, rgba.blue)
  end

  def test_that_color_rgba_alpha_component_can_be_set
    rgba = AsciiPngfy::ColorRGBA.new(0, 0, 0, 0)

    rgba.alpha = 200

    assert_equal(200, rgba.alpha)
  end

  def test_that_color_rgba_raises_error_when_setting_red_component_to_invalid_color_value
    rgba = AsciiPngfy::ColorRGBA.new(0, 0, 0, 0)

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { rgba.red = (-1) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { rgba.red = (256) }
  end

  def test_that_color_rgba_raises_error_when_setting_green_component_to_invalid_color_value
    rgba = AsciiPngfy::ColorRGBA.new(0, 0, 0, 0)

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { rgba.green = (-1) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { rgba.green = (256) }
  end

  def test_that_color_rgba_raises_error_when_setting_blue_component_to_invalid_color_value
    rgba = AsciiPngfy::ColorRGBA.new(0, 0, 0, 0)

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { rgba.blue = (-1) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { rgba.blue = (256) }
  end

  def test_that_color_rgba_raises_error_when_setting_alpha_component_to_invalid_color_value
    rgba = AsciiPngfy::ColorRGBA.new(0, 0, 0, 0)

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { rgba.alpha = (-1) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { rgba.alpha = (256) }
  end

  def test_that_color_rgba_raises_error_when_red_component_initialized_to_invalid_color_value
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { AsciiPngfy::ColorRGBA.new(-1, 0, 0, 0) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { AsciiPngfy::ColorRGBA.new(256, 0, 0, 0) }
  end

  def test_that_color_rgba_raises_error_when_green_component_initialized_to_invalid_color_value
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { AsciiPngfy::ColorRGBA.new(0, -1, 0, 0) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { AsciiPngfy::ColorRGBA.new(0, 256, 0, 0) }
  end

  def test_that_color_rgba_raises_error_when_blue_component_initialized_to_invalid_color_value
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { AsciiPngfy::ColorRGBA.new(0, 0, -1, 0) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { AsciiPngfy::ColorRGBA.new(0, 0, 256, 0) }
  end

  def test_that_color_rgba_raises_error_when_alpha_component_initialized_to_invalid_color_value
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { AsciiPngfy::ColorRGBA.new(0, 0, 0, -1) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { AsciiPngfy::ColorRGBA.new(0, 0, 0, 256) }
  end

  def test_that_color_rgba_instances_equal_when_respective_rgba_components_match
    color =          AsciiPngfy::ColorRGBA.new(50, 100, 150, 200)
    matching_color = AsciiPngfy::ColorRGBA.new(50, 100, 150, 200)

    assert_equal(color, matching_color)
  end

  def test_that_color_rgba_instances_do_not_equal_when_red_rgba_component_mismatches
    color =             AsciiPngfy::ColorRGBA.new(50, 100, 150, 200)
    mismatching_color = AsciiPngfy::ColorRGBA.new(9, 100, 150, 200)

    refute_equal(color, mismatching_color)
  end

  def test_that_color_rgba_instances_do_not_equal_when_green_rgba_component_mismatches
    color =             AsciiPngfy::ColorRGBA.new(50, 100, 150, 200)
    mismatching_color = AsciiPngfy::ColorRGBA.new(50, 18, 150, 200)

    refute_equal(color, mismatching_color)
  end

  def test_that_color_rgba_instances_do_not_equal_when_blue_rgba_component_mismatches
    color =             AsciiPngfy::ColorRGBA.new(50, 100, 150, 200)
    mismatching_color = AsciiPngfy::ColorRGBA.new(50, 100, 27, 200)

    refute_equal(color, mismatching_color)
  end

  def test_that_color_rgba_instances_do_not_equal_when_alpha_rgba_component_mismatches
    color =             AsciiPngfy::ColorRGBA.new(50, 100, 150, 200)
    mismatching_color = AsciiPngfy::ColorRGBA.new(50, 100, 150, 36)

    refute_equal(color, mismatching_color)
  end

  def test_that_color_rgba_raises_error_with_helpful_message_when_setting_red_component_to_invalid_color_value
    rgba = AsciiPngfy::ColorRGBA.new(0, 0, 0, 0)
    expected_error_message = '555 is not a valid red color component value. Must be an Integer in the range (0..255).'

    error_raised = assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) do
      rgba.red = 555
    end

    assert_equal(expected_error_message, error_raised.message)
  end

  def test_that_color_rgba_raises_error_with_helpful_message_when_setting_green_component_to_invalid_color_value
    rgba = AsciiPngfy::ColorRGBA.new(0, 0, 0, 0)
    expected_error_message = '-18 is not a valid green color component value. Must be an Integer in the range (0..255).'

    error_raised = assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) do
      rgba.green = (-18)
    end

    assert_equal(expected_error_message, error_raised.message)
  end

  def test_that_color_rgba_raises_error_with_helpful_message_when_setting_blue_component_to_invalid_color_value
    rgba = AsciiPngfy::ColorRGBA.new(0, 0, 0, 0)
    expected_error_message = '1024 is not a valid blue color component value. Must be an Integer in the range (0..255).'

    error_raised = assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) do
      rgba.blue = 1024
    end

    assert_equal(expected_error_message, error_raised.message)
  end

  def test_that_color_rgba_raises_error_with_helpful_message_when_setting_alpha_component_to_invalid_color_value
    rgba = AsciiPngfy::ColorRGBA.new(0, 0, 0, 0)
    expected_error_message = '-49 is not a valid alpha color component value. Must be an Integer in the range (0..255).'

    error_raised = assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) do
      rgba.alpha = (-49)
    end

    assert_equal(expected_error_message, error_raised.message)
  end
end
# rubocop:enable Metrics/ClassLength
