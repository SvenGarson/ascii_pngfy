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

  def test_that_renderer_set_font_color_returns_instance_of_color_rgba_when_no_argument_is_passed
    test_renderer = TestClasses::TestRenderer.new

    new_font_color = test_renderer.set_font_color

    assert_instance_of(AsciiPngfy::ColorRGBA, new_font_color)
  end

  def test_that_renderer_set_font_color_returns_instance_of_color_rgba_when_some_font_color_components_are_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new

    new_font_color = test_renderer.set_font_color(red: 125, green: 55, blue: 245)

    assert_instance_of(AsciiPngfy::ColorRGBA, new_font_color)
  end

  def test_that_renderer_set_font_color_returns_instance_of_color_rgba_when_all_font_color_components_are_passed_as_argument
    test_renderer = TestClasses::TestRenderer.new

    new_font_color = test_renderer.set_font_color(red: 50, green: 100, blue: 150, alpha: 200)

    assert_instance_of(AsciiPngfy::ColorRGBA, new_font_color)
  end

  def test_that_renderer_set_font_color_returns_instance_of_color_rgba_with_expected_color_component_values
    test_renderer = TestClasses::TestRenderer.new

    new_font_color = test_renderer.set_font_color(red: 151, green: 61, blue: 241, alpha: 11)

    assert_equal(AsciiPngfy::ColorRGBA.new(151, 61, 241, 11), new_font_color)
  end

  def test_that_renderer_set_font_color_returns_instance_of_color_rgba_that_is_a_duplicate_of_the_internal_font_color_rgba_instance
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings
    internal_font_color = test_renderer_settings.font_color

    new_font_color = test_renderer.set_font_color

    refute_same(internal_font_color, new_font_color)
  end
end
