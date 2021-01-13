# frozen_string_literal: true

require_relative 'testing_prerequisites'

class TestRenderer < Minitest::Test
  module TestClasses
    class TestRenderer < AsciiPngfy::Renderer
      def test_settings
        settings
      end
    end
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

  def test_that_renderer_set_vertical_spacing_raises_error_when_argument_is_not_an_integer
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidVerticalSpacingError) do
      test_renderer.set_vertical_spacing(2.8)
    end
  end

  def test_that_renderer_set_vertical_spacing_raises_error_when_argument_is_negative
    test_renderer = TestClasses::TestRenderer.new

    assert_raises(AsciiPngfy::Exceptions::InvalidVerticalSpacingError) do
      test_renderer.set_vertical_spacing(-2)
    end
  end

  def test_that_renderer_set_vertical_spacing_sets_vertical_spacing_to_argument_when_non_negative
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    10.times do |_|
      random_non_zero_spacing = rand(0..100)
      test_renderer.set_vertical_spacing(random_non_zero_spacing)

      assert_equal(random_non_zero_spacing, test_renderer_settings.vertical_spacing)
    end
  end

  def test_that_renderer_set_vertical_spacing_returns_the_last_vertical_spacing_set_as_integer
    test_renderer = TestClasses::TestRenderer.new

    vertical_spacing_set = test_renderer.set_vertical_spacing(7)

    assert_instance_of(Integer, vertical_spacing_set)
  end

  def test_that_renderer_set_vertical_spacing_returns_the_last_vertical_spacing_set
    test_renderer = TestClasses::TestRenderer.new

    vertical_spacing_set = test_renderer.set_vertical_spacing(11)

    assert_equal(11, vertical_spacing_set)
  end

  def test_that_renderer_set_vertical_spacing_raises_error_with_helpful_message_when_argument_invalid
    test_renderer = TestClasses::TestRenderer.new
    expected_error_message = '-3 is not a valid vertical spacing. Must be an Integer in the range (0..).'

    error_raised = assert_raises(AsciiPngfy::Exceptions::InvalidVerticalSpacingError) do
      test_renderer.set_vertical_spacing(-3)
    end

    assert_equal(expected_error_message, error_raised.message)
  end

  def test_that_renderer_pngfy_raises_invalid_replacement_text_error_when_replacement_text_contains_unsupported_chars
    test_renderer = TestClasses::TestRenderer.new
    unsupported_ascii_character = 7.chr

    assert_raises(AsciiPngfy::Exceptions::InvalidReplacementTextError) do
      test_renderer.pngfy('', unsupported_ascii_character)
    end
  end

  def test_that_renderer_pngfy_raises_invalid_replacement_text_error_with_helpful_message_when_chars_unsupported
    test_renderer = TestClasses::TestRenderer.new
    unsupported_characters_string = "A#{1.chr}#{2.chr}#{3.chr}?"

    expected_error_message = "#{unsupported_characters_string.inspect} is not a valid replacement string because "\
                             "[#{1.chr.inspect}, #{2.chr.inspect} and #{3.chr.inspect}] "\
                             'are not supported ASCII characters. '\
                             'Must contain only characters with ASCII code 10 or in the range (32..126).'

    error_raised = assert_raises(AsciiPngfy::Exceptions::InvalidReplacementTextError) do
      test_renderer.pngfy('', unsupported_characters_string)
    end

    assert_equal(expected_error_message, error_raised.message)
  end
end
