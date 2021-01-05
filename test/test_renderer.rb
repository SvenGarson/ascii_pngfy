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

  def test_that_renderer_set_font_color_sets_red_font_color_component_when_defined
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color(red: 101)

    assert_equal(101, test_renderer_settings.font_color.red)
  end

  def test_that_renderer_set_font_color_sets_green_font_color_component_when_defined
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color(green: 117)

    assert_equal(117, test_renderer_settings.font_color.green)
  end

  def test_that_renderer_set_font_color_sets_blue_font_color_component_when_defined
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color(blue: 215)

    assert_equal(215, test_renderer_settings.font_color.blue)
  end

  def test_that_renderer_set_font_color_sets_alpha_font_color_component_when_defined
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color(alpha: 33)

    assert_equal(33, test_renderer_settings.font_color.alpha)
  end

  def test_that_renderer_set_font_color_sets_all_font_color_components_when_defined
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color(red: 30, green: 60, blue: 90, alpha: 120)

    assert_equal(30, test_renderer_settings.font_color.red)
    assert_equal(60, test_renderer_settings.font_color.green)
    assert_equal(90, test_renderer_settings.font_color.blue)
    assert_equal(120, test_renderer_settings.font_color.alpha)
  end

  # checking what has not been set if argument left nil
  def test_that_renderer_set_font_color_does_not_set_red_font_color_component_when_undefined
    test_renderer = TestClasses::TestRenderer.new
    test_renderer_settings = test_renderer.test_settings

    test_renderer.set_font_color

    # default font color is white, so the the red component is 255
    assert_equal(255, test_renderer_settings.font_color.red)
  end
end
