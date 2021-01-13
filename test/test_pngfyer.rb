# frozen_string_literal: true

require_relative 'testing_prerequisites'

# rubocop:disable Metrics/ClassLength
class TestPngfyer < Minitest::Test
  module TestClasses
    class TestPngfyer < AsciiPngfy::Pngfyer
      def test_settings
        settings
      end
    end
  end

  attr_reader(:test_pngfyer, :test_pngfyer_settings)

  def setup
    @test_pngfyer = TestClasses::TestPngfyer.new
    @test_pngfyer_settings = test_pngfyer.test_settings
  end

  def test_that_pngfyer_is_defined
    pngfyer_defined = defined?(AsciiPngfy::Pngfyer)

    refute_nil(pngfyer_defined)
  end

  def test_that_pngfyer_can_be_instantiated
    pngfyer = AsciiPngfy::Pngfyer.new

    assert_instance_of(AsciiPngfy::Pngfyer, pngfyer)
  end

  def test_that_pngfyer_set_font_color_sets_red_font_color_component_when_passed_as_argument
    test_pngfyer.set_font_color(red: 101)

    font_color_red = test_pngfyer_settings.font_color.red
    assert_equal(101, font_color_red)
  end

  def test_that_pngfyer_set_font_color_sets_green_font_color_component_when_passed_as_argument
    test_pngfyer.set_font_color(green: 117)

    font_color_green = test_pngfyer_settings.font_color.green
    assert_equal(117, font_color_green)
  end

  def test_that_pngfyer_set_font_color_sets_blue_font_color_component_when_passed_as_argument
    test_pngfyer.set_font_color(blue: 215)

    font_color_blue = test_pngfyer_settings.font_color.blue
    assert_equal(215, font_color_blue)
  end

  def test_that_pngfyer_set_font_color_sets_alpha_font_color_component_when_passed_as_argument
    test_pngfyer.set_font_color(alpha: 33)

    font_color_alpha = test_pngfyer_settings.font_color.alpha
    assert_equal(33, font_color_alpha)
  end

  def test_that_pngfyer_set_font_color_returns_color_rgba_instance_when_no_argument_is_passed
    new_font_color = test_pngfyer.set_font_color

    assert_instance_of(AsciiPngfy::ColorRGBA, new_font_color)
  end

  def test_that_pngfyer_set_font_color_returns_color_rgba_instance_when_multiple_font_color_components_set
    new_font_color = test_pngfyer.set_font_color(red: 125, green: 55, blue: 245)

    assert_instance_of(AsciiPngfy::ColorRGBA, new_font_color)
  end

  def test_that_pngfyer_set_font_color_returns_color_rgba_instance_when_all_font_color_components_set
    new_font_color = test_pngfyer.set_font_color(red: 50, green: 100, blue: 150, alpha: 200)

    assert_instance_of(AsciiPngfy::ColorRGBA, new_font_color)
  end

  def test_that_pngfyer_set_font_color_returns_color_rgba_instance_with_expected_color_component_values
    new_font_color = test_pngfyer.set_font_color(red: 151, green: 61, blue: 241, alpha: 11)

    assert_equal(AsciiPngfy::ColorRGBA.new(151, 61, 241, 11), new_font_color)
  end

  def test_that_pngfyer_set_font_color_returns_duplicate_of_internal_font_color_instance
    # we want to make sure that the returned ColorRGBA instance cannot be used to change
    # the internal state of the settings
    initial_font_color = test_pngfyer.set_font_color
    initial_font_color.red -= 15
    current_font_color = test_pngfyer.set_font_color

    # we want the returned, current color to not reflect the changes made through the returned objects
    refute_equal(current_font_color, initial_font_color)
  end

  def test_that_pngfyer_set_font_color_raises_error_when_red_font_color_component_set_to_invalid_value
    error_message_too_low = 'Should raise error when red color value is negative.'
    error_message_too_high = 'Should raise error when red color value larger than 255.'

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_low) do
      test_pngfyer.set_font_color(red: -1)
    end

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_high) do
      test_pngfyer.set_font_color(red: 256)
    end
  end

  def test_that_pngfyer_set_font_color_raises_error_when_green_font_color_component_set_to_invalid_value
    error_message_too_low = 'Should raise error when green color value is negative.'
    error_message_too_high = 'Should raise error when green color value larger than 255.'

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_low) do
      test_pngfyer.set_font_color(green: -1)
    end

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_high) do
      test_pngfyer.set_font_color(green: 256)
    end
  end

  def test_that_pngfyer_set_font_color_raises_error_when_blue_font_color_component_set_to_invalid_value
    error_message_too_low = 'Should raise error when blue color value is negative.'
    error_message_too_high = 'Should raise error when blue color value larger than 255.'

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_low) do
      test_pngfyer.set_font_color(blue: -1)
    end

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_high) do
      test_pngfyer.set_font_color(blue: 256)
    end
  end

  def test_that_pngfyer_set_font_color_raises_error_when_alpha_font_color_component_set_to_invalid_value
    error_message_too_low = 'Should raise error when alpha color value is negative.'
    error_message_too_high = 'Should raise error when alpha color value larger than 255.'

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_low) do
      test_pngfyer.set_font_color(alpha: -1)
    end

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_high) do
      test_pngfyer.set_font_color(alpha: 256)
    end
  end

  def test_that_pngfyer_set_background_color_sets_red_background_color_component_when_passed_as_argument
    test_pngfyer.set_background_color(red: 101)

    background_color_red = test_pngfyer_settings.background_color.red
    assert_equal(101, background_color_red)
  end

  def test_that_pngfyer_set_background_color_sets_green_background_color_component_when_passed_as_argument
    test_pngfyer.set_background_color(green: 117)

    background_color_green = test_pngfyer_settings.background_color.green
    assert_equal(117, background_color_green)
  end

  def test_that_pngfyer_set_background_color_sets_blue_background_color_component_when_passed_as_argument
    test_pngfyer.set_background_color(blue: 215)

    background_color_blue = test_pngfyer_settings.background_color.blue
    assert_equal(215, background_color_blue)
  end

  def test_that_pngfyer_set_background_color_sets_alpha_background_color_component_when_passed_as_argument
    test_pngfyer.set_background_color(alpha: 33)

    background_color_alpha = test_pngfyer_settings.background_color.alpha
    assert_equal(33, background_color_alpha)
  end

  def test_that_pngfyer_set_background_color_returns_color_rgba_instance_when_no_argument_is_passed
    new_background_color = test_pngfyer.set_background_color

    assert_instance_of(AsciiPngfy::ColorRGBA, new_background_color)
  end

  def test_that_pngfyer_set_background_color_returns_color_rgba_instance_when_multiple_background_color_components_set
    new_background_color = test_pngfyer.set_background_color(red: 125, green: 55, blue: 245)

    assert_instance_of(AsciiPngfy::ColorRGBA, new_background_color)
  end

  def test_that_pngfyer_set_background_color_returns_color_rgba_instance_when_all_background_color_components_set
    new_background_color = test_pngfyer.set_background_color(red: 50, green: 100, blue: 150, alpha: 200)

    assert_instance_of(AsciiPngfy::ColorRGBA, new_background_color)
  end

  def test_that_pngfyer_set_background_color_returns_color_rgba_instance_with_expected_color_component_values
    new_background_color = test_pngfyer.set_background_color(red: 151, green: 61, blue: 241, alpha: 11)

    assert_equal(AsciiPngfy::ColorRGBA.new(151, 61, 241, 11), new_background_color)
  end

  def test_that_pngfyer_set_background_color_returns_duplicate_of_internal_background_color_instance
    # we want to make sure that the returned ColorRGBA instance cannot be used to change
    # the internal state of the settings
    initial_background_color = test_pngfyer.set_background_color
    initial_background_color.red -= 15
    current_background_color = test_pngfyer.set_background_color

    # we want the returned, current color to not reflect the changes made to the previously returned objects
    refute_equal(current_background_color, initial_background_color)
  end

  def test_that_pngfyer_set_background_color_raises_error_when_red_background_color_component_set_to_invalid_value
    error_message_too_low = 'Should raise error when red color value is negative.'
    error_message_too_high = 'Should raise error when red color value larger than 255.'

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_low) do
      test_pngfyer.set_background_color(red: -1)
    end

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_high) do
      test_pngfyer.set_background_color(red: 256)
    end
  end

  def test_that_pngfyer_set_background_color_raises_error_when_green_background_color_component_set_to_invalid_value
    error_message_too_low = 'Should raise error when green color value is negative.'
    error_message_too_high = 'Should raise error when green color value larger than 255.'

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_low) do
      test_pngfyer.set_background_color(green: -1)
    end

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_high) do
      test_pngfyer.set_background_color(green: 256)
    end
  end

  def test_that_pngfyer_set_background_color_raises_error_when_blue_background_color_component_set_to_invalid_value
    error_message_too_low = 'Should raise error when blue color value is negative.'
    error_message_too_high = 'Should raise error when blue color value larger than 255.'

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_low) do
      test_pngfyer.set_background_color(blue: -1)
    end

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_high) do
      test_pngfyer.set_background_color(blue: 256)
    end
  end

  def test_that_pngfyer_set_background_color_raises_error_when_alpha_background_color_component_set_to_invalid_value
    error_message_too_low = 'Should raise error when alpha color value is negative.'
    error_message_too_high = 'Should raise error when alpha color value larger than 255.'

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_low) do
      test_pngfyer.set_background_color(alpha: -1)
    end

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError, error_message_too_high) do
      test_pngfyer.set_background_color(alpha: 256)
    end
  end
end
# rubocop:enable Metrics/ClassLength
