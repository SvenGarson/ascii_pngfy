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

  attr_reader(
    :test_pngfyer,
    :test_pngfyer_settings, 
    :all_ascii_codes,
    :supported_ascii_codes,
    :un_supported_ascii_codes
    )

  def setup
    @test_pngfyer = TestClasses::TestPngfyer.new
    @test_pngfyer_settings = test_pngfyer.test_settings
    @all_ascii_codes = (0..255).to_a
    @supported_ascii_codes = [10] + (32..126).to_a
    @un_supported_ascii_codes = all_ascii_codes - supported_ascii_codes
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

  def test_that_pngfyer_set_font_height_raises_error_when_argument_is_not_an_integer
    assert_raises(AsciiPngfy::Exceptions::InvalidFontHeightError) do
      test_pngfyer.set_font_height(12.5)
    end
  end

  def test_that_pngfyer_set_font_height_raises_error_when_argument_negative
    assert_raises(AsciiPngfy::Exceptions::InvalidFontHeightError) do
      test_pngfyer.set_font_height(-9)
    end
  end

  def test_that_pngfyer_set_font_height_raises_error_when_argument_zero
    assert_raises(AsciiPngfy::Exceptions::InvalidFontHeightError) do
      test_pngfyer.set_font_height(0)
    end
  end

  def test_that_pngfyer_set_font_height_raises_error_when_argument_less_than_nine
    assert_raises(AsciiPngfy::Exceptions::InvalidFontHeightError) do
      test_pngfyer.set_font_height(8)
    end
  end

  def test_that_pngfyer_set_font_height_sets_font_height_to_argument_when_it_is_a_multiple_of_nine
    9.step((9 * 100), 9) do |multiple_of_nine|
      test_pngfyer.set_font_height(multiple_of_nine)

      assert_equal(multiple_of_nine, test_pngfyer_settings.font_height)
    end
  end

  def test_that_pngfyer_set_font_height_returns_the_last_font_size_set_as_integer
    font_height_set = test_pngfyer.set_font_height(9 * 3)

    assert_instance_of(Integer, font_height_set)
  end

  def test_that_pngfyer_set_font_height_returns_the_last_font_size_set
    font_height_set = test_pngfyer.set_font_height(9 * 5)

    assert_equal(9 * 5, font_height_set)
  end

  def test_that_pngfyer_set_font_height_sets_font_height_to_the_lower_and_closer_multiple_of_nine
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
    # We want the pngfyer to choose the bound closest to the desired height, i.e. 9 or 18
    #
    # So when the desired font number is closer to the lower bound, the lower bound is set as new font height
    # and when the desired font number is closer to the higher bound, the higher bound is set as new font height

    9.step((9 * 100), 9) do |multiple_of_nine|
      # here we set the font height to all possible font heights closest to the lower bound
      # which is all:
      # multiples of 9 + 1
      # multiples of 9 + 2
      # multiples of 9 + 3
      # multiples of 9 + 4
      1.upto(4) do |lower_bound_distance|
        lower_bound_desired_font_height = multiple_of_nine + lower_bound_distance

        font_height_set = test_pngfyer.set_font_height(lower_bound_desired_font_height)

        assert_equal(multiple_of_nine, font_height_set)
      end
    end
  end

  def test_that_pngfyer_set_font_height_sets_font_height_to_the_higher_and_closer_multiple_of_nine
    # The same as the previous test with the difference that we now test for the higher bound

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

        font_height_set = test_pngfyer.set_font_height(higher_bound_desired_font_height)

        assert_equal(next_multiple_of_nine, font_height_set)
      end
    end
  end

  def test_that_pngfyer_set_font_height_raises_error_with_helpful_message_when_argument_invalid
    expected_error_message = '-55 is not a valid font size. Must be an Integer in the range (9..).'

    error_raised = assert_raises(AsciiPngfy::Exceptions::InvalidFontHeightError) do
      test_pngfyer.set_font_height(-55)
    end

    assert_equal(expected_error_message, error_raised.message)
  end

  def test_that_pngfyer_set_horizontal_spacing_raises_error_when_argument_is_not_an_integer
    assert_raises(AsciiPngfy::Exceptions::InvalidHorizontalSpacingError) do
      test_pngfyer.set_horizontal_spacing(2.8)
    end
  end

  def test_that_pngfyer_set_horizontal_spacing_raises_error_when_argument_is_negative
    assert_raises(AsciiPngfy::Exceptions::InvalidHorizontalSpacingError) do
      test_pngfyer.set_horizontal_spacing(-2)
    end
  end

  def test_that_pngfyer_set_horizontal_spacing_sets_horizontal_spacing_to_argument_when_non_negative
    10.times do |_|
      random_non_zero_spacing = rand(0..100)

      test_pngfyer.set_horizontal_spacing(random_non_zero_spacing)

      assert_equal(random_non_zero_spacing, test_pngfyer_settings.horizontal_spacing)
    end
  end

  def test_that_pngfyer_set_horizontal_spacing_returns_the_last_horizontal_spacing_set_as_integer
    horizontal_spacing_set = test_pngfyer.set_horizontal_spacing(7)

    assert_instance_of(Integer, horizontal_spacing_set)
  end

  def test_that_pngfyer_set_horizontal_spacing_returns_the_last_horizontal_spacing_set
    horizontal_spacing_set = test_pngfyer.set_horizontal_spacing(11)

    assert_equal(11, horizontal_spacing_set)
  end

  def test_that_pngfyer_set_horizontal_spacing_raises_error_with_helpful_message_when_argument_invalid
    expected_error_message = '-3 is not a valid horizontal spacing. Must be an Integer in the range (0..).'

    error_raised = assert_raises(AsciiPngfy::Exceptions::InvalidHorizontalSpacingError) do
      test_pngfyer.set_horizontal_spacing(-3)
    end

    assert_equal(expected_error_message, error_raised.message)
  end

  def test_that_pngfyer_set_vertical_spacing_raises_error_when_argument_is_not_an_integer
    assert_raises(AsciiPngfy::Exceptions::InvalidVerticalSpacingError) do
      test_pngfyer.set_vertical_spacing(2.8)
    end
  end

  def test_that_pngfyer_set_vertical_spacing_raises_error_when_argument_is_negative
    assert_raises(AsciiPngfy::Exceptions::InvalidVerticalSpacingError) do
      test_pngfyer.set_vertical_spacing(-2)
    end
  end

  def test_that_pngfyer_set_vertical_spacing_sets_vertical_spacing_to_argument_when_non_negative
    10.times do |_|
      random_non_zero_spacing = rand(0..100)

      test_pngfyer.set_vertical_spacing(random_non_zero_spacing)

      assert_equal(random_non_zero_spacing, test_pngfyer_settings.vertical_spacing)
    end
  end

  def test_that_pngfyer_set_vertical_spacing_returns_the_last_vertical_spacing_set_as_integer
    vertical_spacing_set = test_pngfyer.set_vertical_spacing(7)

    assert_instance_of(Integer, vertical_spacing_set)
  end

  def test_that_pngfyer_set_vertical_spacing_returns_the_last_vertical_spacing_set
    vertical_spacing_set = test_pngfyer.set_vertical_spacing(11)

    assert_equal(11, vertical_spacing_set)
  end

  def test_that_pngfyer_set_vertical_spacing_raises_error_with_helpful_message_when_argument_invalid
    expected_error_message = '-3 is not a valid vertical spacing. Must be an Integer in the range (0..).'

    error_raised = assert_raises(AsciiPngfy::Exceptions::InvalidVerticalSpacingError) do
      test_pngfyer.set_vertical_spacing(-3)
    end

    assert_equal(expected_error_message, error_raised.message)
  end

  def test_that_pngfyer_set_text_raises_invalid_replacement_text_error_when_replacement_text_contains_unsupported_chars
    un_supported_ascii_codes.each do |un_supported_code|
      un_supported_character = un_supported_code.chr

      assert_raises(AsciiPngfy::Exceptions::InvalidReplacementTextError) do 
        test_pngfyer.set_text('', un_supported_character)
      end
    end
  end

  def test_that_pngfyer_set_text_raises_invalid_replacement_text_error_with_helpful_message_when_chars_unsupported
skip
=begin
  
  error message should desribe ALL unsupported characters for the user to see so he does not have to
  fiddle until all problems are gone

  >tests to execute
    - use ALL unsupported characters to test that all work in error as expected
    - use a combination of single and multiple char strings that are not supported

  > approach
    - build a local array of unsupported chars to use
    - use up unuspported chars from that array and add it to a random string
      by prepending/appending or interpolating the unsupported chars
      and maybe even inject them at a random spot for each character?

      This seems a og of logic and maybe need its own test?

=end

    un_supported_ascii_codes.each do |un_supported_code|
      un_supported_character = un_supported_code.chr

      error_raised = assert_raises(AsciiPngfy::Exceptions::InvalidReplacementTextError) do 
        test_pngfyer.set_text('', un_supported_character)
      end

      expected_error_message = "#{unsupported_characters_string.inspect} is not a valid replacement string because "\
                             "[#{1.chr.inspect}, #{2.chr.inspect} and #{3.chr.inspect}] "\
                             'are not supported ASCII characters. '\
                             'Must contain only characters with ASCII code 10 or in the range (32..126).'

      assert_equal(expected_error_message, error_raised)
    end

skip
    expected_error_message = "#{unsupported_characters_string.inspect} is not a valid replacement string because "\
                             "[#{1.chr.inspect}, #{2.chr.inspect} and #{3.chr.inspect}] "\
                             'are not supported ASCII characters. '\
                             'Must contain only characters with ASCII code 10 or in the range (32..126).'

    error_raised = assert_raises(AsciiPngfy::Exceptions::InvalidReplacementTextError) do
      test_renderer.pngfy('', unsupported_characters_string)
    end

    assert_equal(expected_error_message, error_raised.message)
  end

  # other 

end
# rubocop:enable Metrics/ClassLength
