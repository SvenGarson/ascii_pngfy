# frozen_string_literal: true

require_relative 'testing_prerequisites'

class TestResult < Minitest::Test
  attr_reader(:pngfyer)

  def setup
    @pngfyer = AsciiPngfy::Pngfyer.new
  end

  def test_that_result_png_returns_chunky_png_image_instance
    result = pngfyer.pngfy

    png = result.png

    assert_instance_of(ChunkyPNG::Image, png)
  end

  def test_that_result_png_width_returns_integer
    result = pngfyer.pngfy

    png_width = result.png.width

    assert_instance_of(Integer, png_width)
  end

  def test_that_result_png_width_returns_expected_value_for_settings
    longest_line = "Choose your weapon:"
    longest_line_length = longest_line.length
    text = "#{longest_line}\n- Sword\n- Axe"

    expected_horizontal_spacing_count = longest_line_length - 1

    font_height = 27
    horizontal_spacing = 4
    glyph_width = 5

    expected_png_width =
      (longest_line_length * glyph_width) + (expected_horizontal_spacing_count * horizontal_spacing)

    # > Expected png output
    # +-------------------+
    # |Choose your weapon:|
    # |- Sword            |
    # |- Axe              |
    # +-------------------+
    
    pngfyer.set_font_height(font_height)
    pngfyer.set_horizontal_spacing(horizontal_spacing)
    pngfyer.set_text(text)
    result = pngfyer.pngfy

    actual_png_width = result.png.width

    assert_equal(expected_png_width, actual_png_width)
  end

  def test_that_result_png_height_returns_integer
    result = pngfyer.pngfy

    png_height = result.png.height

    assert_instance_of(Integer, png_height)
  end

  def test_that_result_png_height_returns_expected_value_for_settings
    longest_line = "Choose your weapon:"
    text = "#{longest_line}\n- Sword\n- Axe"
    lines_count = text.split("\n", -1).length

    expected_vertical_spacing_count = lines_count - 1

    font_height = 27
    vertical_spacing = 2
    glyph_height = 9

    expected_png_height =
      (lines_count * glyph_height) + (expected_vertical_spacing_count * vertical_spacing)

    # > Expected png output
    # +-------------------+
    # |Choose your weapon:|
    # |- Sword            |
    # |- Axe              |
    # +-------------------+
    
    pngfyer.set_font_height(font_height)
    pngfyer.set_vertical_spacing(vertical_spacing)
    pngfyer.set_text(text)
    result = pngfyer.pngfy

    actual_png_height = result.png.height

    assert_equal(expected_png_height, actual_png_height)
  end

  def test_that_result_render_width_returns_integer
    result = pngfyer.pngfy

    render_width = result.render_width

    assert_instance_of(Integer, render_width)
  end

  def test_that_result_render_width_returns_integer
skip
    
  end
end
