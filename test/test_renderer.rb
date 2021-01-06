# frozen_string_literal: true

require_relative 'testing_prerequisites'

# rubocop:disable Metrics/ClassLength
class TestRenderer < Minitest::Test
  module TestClasses
    class TestRenderer < AsciiPngfy::Renderer
      def test_settings
        settings
      end
    end
  end

  def test_that_renderer_is_defined
    renderer_defined = defined?(AsciiPngfy::Renderer)

    refute_nil(renderer_defined)
  end

  def test_that_renderer_can_be_instantiated
    renderer = AsciiPngfy::Renderer.new

    assert_instance_of(AsciiPngfy::Renderer, renderer)
  end

  def test_that_renderer_set_font_color_sets_red_font_color_component_when_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color(red: 101)

    assert_equal(101, test_renderer_settings.font_color.red)
  end

  def test_that_renderer_set_font_color_sets_green_font_color_component_when_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color(green: 117)

    assert_equal(117, test_renderer_settings.font_color.green)
  end

  def test_that_renderer_set_font_color_sets_blue_font_color_component_when_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color(blue: 215)

    assert_equal(215, test_renderer_settings.font_color.blue)
  end

  def test_that_renderer_set_font_color_sets_alpha_font_color_component_when_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color(alpha: 33)

    assert_equal(33, test_renderer_settings.font_color.alpha)
  end

  def test_that_renderer_set_font_color_sets_all_font_color_components_when_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color(red: 30, green: 60, blue: 90, alpha: 120)

    assert_equal(30, test_renderer_settings.font_color.red)
    assert_equal(60, test_renderer_settings.font_color.green)
    assert_equal(90, test_renderer_settings.font_color.blue)
    assert_equal(120, test_renderer_settings.font_color.alpha)
  end

  def test_that_renderer_set_font_color_does_not_set_red_font_color_component_when_not_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color

    # default font color is white, so the the red component is 255
    assert_equal(255, test_renderer_settings.font_color.red)
  end

  def test_that_renderer_set_font_color_does_not_set_green_font_color_component_when_not_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color

    # default font color is white, so the the green component is 255
    assert_equal(255, test_renderer_settings.font_color.green)
  end

  def test_that_renderer_set_font_color_does_not_set_blue_font_color_component_when_not_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color

    # default font color is white, so the the blue component is 255
    assert_equal(255, test_renderer_settings.font_color.blue)
  end

  def test_that_renderer_set_font_color_does_not_set_alpha_font_color_component_when_not_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color

    # default font color is opaque white, so the the alpha component is 255
    assert_equal(255, test_renderer_settings.font_color.alpha)
  end

  def test_that_renderer_set_font_color_returns_color_rgba_instance_when_no_argument_is_passed
    test_renderer = TestClasses::TestRenderer.new

    new_font_color = test_renderer.set_font_color

    assert_instance_of(AsciiPngfy::ColorRGBA, new_font_color)
  end

  def test_that_renderer_set_font_color_returns_color_rgba_instance_when_multiple_font_color_components_are_set
    test_renderer = TestClasses::TestRenderer.new

    new_font_color = test_renderer.set_font_color(red: 125, green: 55, blue: 245)

    assert_instance_of(AsciiPngfy::ColorRGBA, new_font_color)
  end

  def test_that_renderer_set_font_color_returns_color_rgba_instance_when_all_font_color_components_are_set
    test_renderer = TestClasses::TestRenderer.new

    new_font_color = test_renderer.set_font_color(red: 50, green: 100, blue: 150, alpha: 200)

    assert_instance_of(AsciiPngfy::ColorRGBA, new_font_color)
  end

  def test_that_renderer_set_font_color_returns_color_rgba_instance_with_expected_color_component_values
    test_renderer = TestClasses::TestRenderer.new

    new_font_color = test_renderer.set_font_color(red: 151, green: 61, blue: 241, alpha: 11)

    assert_equal(AsciiPngfy::ColorRGBA.new(151, 61, 241, 11), new_font_color)
  end

  def test_that_renderer_set_font_color_returns_duplicate_of_internal_font_color_instance
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings
    internal_font_color = test_renderer_settings.font_color

    new_font_color = test_renderer.set_font_color

    refute_same(internal_font_color, new_font_color)
  end

  def test_that_renderer_set_font_color_raises_error_when_red_font_color_component_set_to_invalid_value
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_font_color(red: -1) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_font_color(red: 256) }
  end

  def test_that_renderer_set_font_color_raises_error_when_green_font_color_component_set_to_invalid_value
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_font_color(green: -1) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_font_color(green: 256) }
  end

  def test_that_renderer_set_font_color_raises_error_when_blue_font_color_component_set_to_invalid_value
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_font_color(blue: -1) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_font_color(blue: 256) }
  end

  def test_that_renderer_set_font_color_raises_error_when_alpha_font_color_component_set_to_invalid_value
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_font_color(alpha: -1) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_font_color(alpha: 256) }
  end

  # Now the same thing for Renderer#set_background_color
  def test_that_renderer_set_background_color_sets_red_background_color_component_when_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_background_color(red: 101)

    assert_equal(101, test_renderer_settings.background_color.red)
  end

  def test_that_renderer_set_background_color_sets_green_background_color_component_when_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_background_color(green: 117)

    assert_equal(117, test_renderer_settings.background_color.green)
  end

  def test_that_renderer_set_background_color_sets_blue_background_color_component_when_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_background_color(blue: 215)

    assert_equal(215, test_renderer_settings.background_color.blue)
  end

  def test_that_renderer_set_background_color_sets_alpha_background_color_component_when_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_background_color(alpha: 33)

    assert_equal(33, test_renderer_settings.background_color.alpha)
  end

  def test_that_renderer_set_background_color_sets_all_background_color_components_when_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_background_color(red: 30, green: 60, blue: 90, alpha: 120)

    assert_equal(30, test_renderer_settings.background_color.red)
    assert_equal(60, test_renderer_settings.background_color.green)
    assert_equal(90, test_renderer_settings.background_color.blue)
    assert_equal(120, test_renderer_settings.background_color.alpha)
  end

  def test_that_renderer_set_background_color_does_not_set_red_background_color_component_when_not_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_background_color

    # default background color is black, so the the red component is 0
    assert_equal(0, test_renderer_settings.background_color.red)
  end

  def test_that_renderer_set_background_color_does_not_set_green_background_color_component_when_not_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_background_color

    # default background color is black, so the the green component is 0
    assert_equal(0, test_renderer_settings.background_color.green)
  end

  def test_that_renderer_set_background_color_does_not_set_blue_background_color_component_when_not_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_background_color

    # default background color is black, so the the blue component is 0
    assert_equal(0, test_renderer_settings.background_color.blue)
  end

  def test_that_renderer_set_background_color_does_not_set_alpha_background_color_component_when_not_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_background_color

    # default background color is opaque black, so the the alpha component is 255
    assert_equal(255, test_renderer_settings.background_color.alpha)
  end

  def test_that_renderer_set_background_color_returns_color_rgba_instance_when_no_argument_is_passed
    test_renderer = TestClasses::TestRenderer.new

    new_background_color = test_renderer.set_background_color

    assert_instance_of(AsciiPngfy::ColorRGBA, new_background_color)
  end

  def test_that_renderer_set_background_color_returns_color_rgba_instance_when_multiple_background_color_components_set
    test_renderer = TestClasses::TestRenderer.new

    new_background_color = test_renderer.set_background_color(red: 125, green: 55, blue: 245)

    assert_instance_of(AsciiPngfy::ColorRGBA, new_background_color)
  end

  def test_that_renderer_set_background_color_returns_color_rgba_instance_when_all_background_color_components_are_set
    test_renderer = TestClasses::TestRenderer.new

    new_background_color = test_renderer.set_background_color(red: 50, green: 100, blue: 150, alpha: 200)

    assert_instance_of(AsciiPngfy::ColorRGBA, new_background_color)
  end

  def test_that_renderer_set_background_color_returns_color_rgba_instance_with_expected_color_component_values
    test_renderer = TestClasses::TestRenderer.new

    new_background_color = test_renderer.set_background_color(red: 151, green: 61, blue: 241, alpha: 11)

    assert_equal(AsciiPngfy::ColorRGBA.new(151, 61, 241, 11), new_background_color)
  end

  def test_that_renderer_set_background_color_returns_duplicate_of_internal_background_color_instance
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings
    internal_background_color = test_renderer_settings.background_color

    new_background_color = test_renderer.set_background_color

    refute_same(internal_background_color, new_background_color)
  end

  def test_that_renderer_set_background_color_raises_error_when_red_background_color_component_set_to_invalid_value
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_background_color(red: -1) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_background_color(red: 256) }
  end

  def test_that_renderer_set_background_color_raises_error_when_green_background_color_component_set_to_invalid_value
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_background_color(green: -1) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_background_color(green: 256) }
  end

  def test_that_renderer_set_background_color_raises_error_when_blue_background_color_component_set_to_invalid_value
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_background_color(blue: -1) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_background_color(blue: 256) }
  end

  def test_that_renderer_set_background_color_raises_error_when_alpha_background_color_component_set_to_invalid_value
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_background_color(alpha: -1) }
    assert_raises(AsciiPngfy::Exceptions::InvalidRGBAColorValueError) { test_renderer.set_background_color(alpha: 256) }
  end

  def test_that_renderer_set_font_height_closest_to_raises_error_when_argument_is_not_an_integer
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidFontHeightError) do
      test_renderer.set_font_height_closest_to(12.5)
    end
  end

  def test_that_renderer_set_font_height_closest_to_raises_error_when_argument_negative
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidFontHeightError) do
      test_renderer.set_font_height_closest_to(-9)
    end
  end

  def test_that_renderer_set_font_height_closest_to_raises_error_when_argument_zero
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidFontHeightError) do
      test_renderer.set_font_height_closest_to(0)
    end
  end

  def test_that_renderer_set_font_height_closest_to_raises_error_when_argument_less_than_nine
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidFontHeightError) do
      test_renderer.set_font_height_closest_to(8)
    end
  end

  def test_that_renderer_set_font_height_closest_to_sets_font_height_to_argument_when_it_is_a_multiple_of_nine
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    9.step((9 * 100), 9) do |multiple_of_nine|
      test_renderer.set_font_height_closest_to(multiple_of_nine)

      assert_equal(multiple_of_nine, test_renderer_settings.font_height)
    end
  end

  def test_that_renderer_set_font_height_closest_to_returns_the_last_font_size_set_as_integer
    test_renderer = TestClasses::TestRenderer.new

    font_height_set = test_renderer.set_font_height_closest_to(9 * 3)

    assert_instance_of(Integer, font_height_set)
  end

  def test_that_renderer_set_font_height_closest_to_returns_the_last_font_size_set
    test_renderer = TestClasses::TestRenderer.new

    font_height_set = test_renderer.set_font_height_closest_to(9 * 5)

    assert_equal(9 * 5, font_height_set)
  end

  def test_that_renderer_set_font_height_closest_to_sets_font_height_to_the_lower_and_closer_multiple_of_nine
    # When the desired font height is in the valid range but not a multipe of nine there are
    # 4 possible desired font numbers that are closer to the multiple of nine LESS THAN the desired height
    # and
    # 4 possible desired font numbers that are closer to the multiple of nine LARGER THAN the desired height
    #
    # For example:
    #
    # desired font height = 12
    # The possible multiple of 9 font heights are 9 (lower bound of 12) or 18 (higher bound of 12)
    #
    # The possible font heights closer to the lower bound are [10, 11, 12, 13] with a distance of [+1, +2, +3, +4]
    # The possible font heights closer to the higher bound are [14, 15, 16, 17] with a distance of [+5, +6, +7, +8]
    # We want the renderer to choose the bound closest to the desired height, i.e. 9 or 18
    #
    # So when the desired font number is closer to the lower bound, the lower bound is set as new font height
    # and when the desired font number is closer to the higher bound, the higher bound is set as new font height

    test_renderer = TestClasses::TestRenderer.new

    9.step((9 * 100), 9) do |multiple_of_nine|
      # here we set the font height to all possible font heights closest to the lower bound
      # which is all:
      # multiples of 9 + 1
      # multiples of 9 + 2
      # multiples of 9 + 3
      # multiples of 9 + 4
      1.upto(4) do |lower_bound_distance|
        lower_bound_desired_font_height = multiple_of_nine + lower_bound_distance
        font_height_set = test_renderer.set_font_height_closest_to(lower_bound_desired_font_height)

        assert_equal(multiple_of_nine, font_height_set)
      end
    end
  end

  def test_that_renderer_set_font_height_closest_to_sets_font_height_to_the_higher_and_closer_multiple_of_nine
    # The same as the previous test with the difference that we now test for the higher bound
    test_renderer = TestClasses::TestRenderer.new

    9.step((9 * 100), 9) do |multiple_of_nine|
      next_multiple_of_nine = multiple_of_nine + 9
      # here we set the font height to all possible font heights closest to the higher bound
      # which is all:
      # multiples of 9 + 5
      # multiples of 9 + 6
      # multiples of 9 + 7
      # multiples of 9 + 8
      5.upto(8) do |higher_bound_distance|
        higher_bound_desired_font_height = multiple_of_nine + higher_bound_distance
        font_height_set = test_renderer.set_font_height_closest_to(higher_bound_desired_font_height)

        assert_equal(next_multiple_of_nine, font_height_set)
      end
    end
  end

  def test_that_renderer_set_font_height_closest_to_raises_error_with_helpful_message_when_argument_invalid
    test_renderer = TestClasses::TestRenderer.new
    expected_error_message = '-55 is not a valid font size. Must be an Integer in the range (9..).'

    error_raised = assert_raises(AsciiPngfy::Exceptions::InvalidFontHeightError) do
      test_renderer.set_font_height_closest_to(-55)
    end

    assert_equal(expected_error_message, error_raised.message)
  end

  def test_that_renderer_set_horizontal_spacing_raises_error_when_argument_is_not_an_integer
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidHorizontalSpacingError) do
      test_renderer.set_horizontal_spacing(2.8)
    end
  end

  def test_that_renderer_set_horizontal_spacing_raises_error_when_argument_is_negative
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidHorizontalSpacingError) do
      test_renderer.set_horizontal_spacing(-2)
    end
  end

  def test_that_renderer_set_horizontal_spacing_sets_horizontal_spacing_to_argument_when_non_negative
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    10.times do |_|
      random_non_zero_spacing = rand(0..100)
      test_renderer.set_horizontal_spacing(random_non_zero_spacing)

      assert_equal(random_non_zero_spacing, test_renderer_settings.horizontal_spacing)
    end
  end

  def test_that_renderer_set_horizontal_spacing_returns_the_last_horizontal_spacing_set_as_integer
    test_renderer = TestClasses::TestRenderer.new

    horizontal_spacing_set = test_renderer.set_horizontal_spacing(7)

    assert_instance_of(Integer, horizontal_spacing_set)
  end

  def test_that_renderer_set_horizontal_spacing_returns_the_last_horizontal_spacing_set
    test_renderer = TestClasses::TestRenderer.new

    horizontal_spacing_set = test_renderer.set_horizontal_spacing(11)

    assert_equal(11, horizontal_spacing_set)
  end

  def test_that_renderer_set_horizontal_spacing_raises_error_with_helpful_message_when_argument_invalid
    test_renderer = TestClasses::TestRenderer.new
    expected_error_message = '-3 is not a valid horizontal spacing. Must be an Integer in the range (0..).'

    error_raised = assert_raises(AsciiPngfy::Exceptions::InvalidHorizontalSpacingError) do
      test_renderer.set_horizontal_spacing(-3)
    end

    assert_equal(expected_error_message, error_raised.message)
  end
end
# rubocop:enable Metrics/ClassLength
