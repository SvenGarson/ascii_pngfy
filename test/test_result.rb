# frozen_string_literal: true

require 'testing_prerequisites'
require 'chunky_png'

# rubocop:disable Metrics/ClassLength, Metrics/MethodLength
class TestResult < Minitest::Test
  module Helpers
    class Vec2i
      attr_accessor(:x, :y)

      def initialize(initial_x = 0, initial_y = 0)
        self.x = initial_x
        self.y = initial_y
      end

      def to_s
        "[#{x}, #{y}]"
      end
    end

    class AABB
      attr_reader(:min, :max)

      def initialize(min_x, min_y, max_x, max_y)
        @min = Vec2i.new(min_x, min_y)
        @max = Vec2i.new(max_x, max_y)
      end

      def each_pixel
        return nil unless block_given?

        min.y.upto(max.y) do |tile_y|
          min.x.upto(max.x) do |tile_x|
            yield(tile_x, tile_y)
          end
        end
      end

      def overlaps_coordinates?(some_x, some_y)
        (min.x..max.x).cover?(some_x) && (min.y..max.y).cover?(some_y)
      end

      def to_s
        "min#{min} max#{max}"
      end
    end
  end

  attr_reader(
    :pngfyer,
    :design_pngfyer,
    :supported_ascii_characters,
    :supported_ascii_characters_without_newline
  )

  def setup
    @pngfyer = AsciiPngfy::Pngfyer.new(use_glyph_designs: false)
    @design_pngfyer = AsciiPngfy::Pngfyer.new
    @supported_ascii_characters = ([10] + (32..126).to_a).map(&:chr)
    @supported_ascii_characters_without_newline = (32..126).to_a.map(&:chr)
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

  # rubocop:disable Metrics/AbcSize
  def test_that_result_png_width_returns_expected_value_for_settings
    longest_line = 'Choose your weapon:'
    longest_line_length = longest_line.length
    text = "#{longest_line}\n- Sword\n- Axe"

    expected_horizontal_spacing_count = longest_line_length - 1

    font_height = 27
    horizontal_spacing = 4
    glyph_width = 5

    expected_png_width = (longest_line_length * glyph_width) + (expected_horizontal_spacing_count * horizontal_spacing)

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
  # rubocop:enable Metrics/AbcSize

  def test_that_result_png_height_returns_integer
    result = pngfyer.pngfy

    png_height = result.png.height

    assert_instance_of(Integer, png_height)
  end

  # rubocop:disable Metrics/AbcSize
  def test_that_result_png_height_returns_expected_value_for_settings
    longest_line = 'Choose your weapon:'
    text = "#{longest_line}\n- Sword\n- Axe"
    lines_count = text.split("\n", -1).length

    expected_vertical_spacing_count = lines_count - 1

    font_height = 27
    vertical_spacing = 2
    glyph_height = 9

    expected_png_height = (lines_count * glyph_height) + (expected_vertical_spacing_count * vertical_spacing)

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
  # rubocop:enable Metrics/AbcSize

  def test_that_result_render_width_returns_integer
    result = pngfyer.pngfy

    render_width = result.render_width

    assert_instance_of(Integer, render_width)
  end

  # rubocop:disable Metrics/AbcSize
  def test_that_result_render_width_returns_expected_scaled_png_width_value_for_settings
    longest_line = 'Choose your weapon:'
    longest_line_length = longest_line.length
    text = "#{longest_line}\n- Sword\n- Axe"

    expected_horizontal_spacing_count = longest_line_length - 1

    font_height = 27
    horizontal_spacing = 4
    glyph_width = 5
    glyph_height = 9

    expected_png_width = (longest_line_length * glyph_width) + (expected_horizontal_spacing_count * horizontal_spacing)
    png_width_to_render_width_multiplier = font_height / glyph_height
    expected_render_width = expected_png_width * png_width_to_render_width_multiplier

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

    actual_render_width = result.render_width

    assert_equal(expected_render_width, actual_render_width)
  end
  # rubocop:enable Metrics/AbcSize

  def test_that_result_render_height_returns_integer
    result = pngfyer.pngfy

    render_height = result.render_height

    assert_instance_of(Integer, render_height)
  end

  # rubocop:disable Metrics/AbcSize
  def test_that_result_render_height_returns_expected_scaled_png_height_value_for_settings
    longest_line = 'Choose your weapon:'
    text = "#{longest_line}\n- Sword\n- Axe"
    lines_count = text.split("\n", -1).length

    expected_vertical_spacing_count = lines_count - 1

    font_height = 27
    vertical_spacing = 2
    glyph_height = 9

    expected_png_height = (lines_count * glyph_height) + (expected_vertical_spacing_count * vertical_spacing)
    png_height_to_render_height_multiplier = font_height / glyph_height
    expected_render_height = expected_png_height * png_height_to_render_height_multiplier

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

    actual_render_height = result.render_height

    assert_equal(expected_render_height, actual_render_height)
  end
  # rubocop:enable Metrics/AbcSize

  def test_that_result_settings_font_color_returns_the_expected_font_color_set_previously
    pngfyer.set_font_color(red: 58, green: 249, blue: 101, alpha: 77)
    expected_returned_font_color = AsciiPngfy::ColorRGBA.new(58, 249, 101, 77)
    result = pngfyer.pngfy

    settings_font_color = result.settings.font_color

    assert_equal(expected_returned_font_color, settings_font_color)
  end

  def test_that_result_settings_set_font_color_raises_no_method_error
    result = pngfyer.pngfy

    assert_raises(NoMethodError) do
      result.settings.set_font_color(red: 50, green: 100, blue: 150, alpha: 200)
    end
  end

  def test_that_result_settings_font_color_reflects_settings_at_result_creation_time_and_not_future_changes
    pngfyer.set_font_color(red: 111, green: 121, blue: 131, alpha: 141)
    oldest_result = pngfyer.pngfy

    # the following setting changes and result creation should not affect the previous result in any way
    pngfyer.set_font_color(red: 0, green: 0, blue: 0, alpha: 0)
    most_recent_result = pngfyer.pngfy

    # this is why we pull the Result#settings data after a setting has been changed
    oldest_font_color = oldest_result.settings.font_color
    most_recent_font_color = most_recent_result.settings.font_color

    refute_equal(oldest_font_color, most_recent_font_color)
  end

  def test_that_result_settings_background_color_returns_the_expected_background_color_set_previously
    pngfyer.set_background_color(red: 15, green: 208, blue: 189, alpha: 96)
    expected_returned_background_color = AsciiPngfy::ColorRGBA.new(15, 208, 189, 96)
    result = pngfyer.pngfy

    settings_background_color = result.settings.background_color

    assert_equal(expected_returned_background_color, settings_background_color)
  end

  def test_that_result_settings_set_background_color_raises_no_method_error
    result = pngfyer.pngfy

    assert_raises(NoMethodError) do
      result.settings.set_background_color(red: 215, green: 108, blue: 62, alpha: 49)
    end
  end

  def test_that_result_settings_background_color_reflects_settings_at_result_creation_time_and_not_future_changes
    pngfyer.set_background_color(red: 159, green: 167, blue: 65, alpha: 255)
    oldest_result = pngfyer.pngfy

    # the following setting changes and result creation should not affect the previous result in any way
    pngfyer.set_background_color(red: 0, green: 0, blue: 0, alpha: 0)
    most_recent_result = pngfyer.pngfy

    # this is why we pull the Result#settings data after a setting has been changed
    oldest_background_color = oldest_result.settings.background_color
    most_recent_background_color = most_recent_result.settings.background_color

    refute_equal(oldest_background_color, most_recent_background_color)
  end

  def test_that_result_settings_font_height_returns_the_expected_font_height_set_previously
    pngfyer.set_font_height(81)
    expected_returned_font_height = 81
    result = pngfyer.pngfy

    settings_font_height = result.settings.font_height

    assert_equal(expected_returned_font_height, settings_font_height)
  end

  def test_that_result_settings_set_font_height_raises_no_method_error
    result = pngfyer.pngfy

    assert_raises(NoMethodError) do
      result.settings.set_font_height(27)
    end
  end

  def test_that_result_settings_font_height_reflects_settings_at_result_creation_time_and_not_future_changes
    pngfyer.set_font_height(18)
    oldest_result = pngfyer.pngfy

    # the following setting changes and result creation should not affect the previous result in any way
    pngfyer.set_font_height(45)
    most_recent_result = pngfyer.pngfy

    # this is why we pull the Result#settings data after a setting has been changed
    oldest_font_height = oldest_result.settings.font_height
    most_recent_font_height = most_recent_result.settings.font_height

    refute_equal(oldest_font_height, most_recent_font_height)
  end

  def test_that_result_settings_horizontal_spacing_returns_the_expected_horizontal_spacing_set_previously
    pngfyer.set_horizontal_spacing(7)
    expected_returned_horizontal_spacing = 7
    result = pngfyer.pngfy

    settings_horizontal_spacing = result.settings.horizontal_spacing

    assert_equal(expected_returned_horizontal_spacing, settings_horizontal_spacing)
  end

  def test_that_result_settings_set_horizontal_spacing_raises_no_method_error
    result = pngfyer.pngfy

    assert_raises(NoMethodError) do
      result.settings.set_horizontal_spacing(2)
    end
  end

  def test_that_result_settings_horizontal_spacing_reflects_settings_at_result_creation_time_and_not_future_changes
    pngfyer.set_horizontal_spacing(10)
    oldest_result = pngfyer.pngfy

    # the following setting changes and result creation should not affect the previous result in any way
    pngfyer.set_horizontal_spacing(22)
    most_recent_result = pngfyer.pngfy

    # this is why we pull the Result#settings data after a setting has been changed
    oldest_horizontal_spacing = oldest_result.settings.horizontal_spacing
    most_recent_horizontal_spacing = most_recent_result.settings.horizontal_spacing

    refute_equal(oldest_horizontal_spacing, most_recent_horizontal_spacing)
  end

  def test_that_result_settings_vertical_spacing_returns_the_expected_vertical_spacing_set_previously
    pngfyer.set_vertical_spacing(3)
    expected_returned_vertical_spacing = 3
    result = pngfyer.pngfy

    settings_vertical_spacing = result.settings.vertical_spacing

    assert_equal(expected_returned_vertical_spacing, settings_vertical_spacing)
  end

  def test_that_result_settings_set_vertical_spacing_raises_no_method_error
    result = pngfyer.pngfy

    assert_raises(NoMethodError) do
      result.settings.set_vertical_spacing(0)
    end
  end

  def test_that_result_settings_vertical_spacing_reflects_settings_at_result_creation_time_and_not_future_changes
    pngfyer.set_vertical_spacing(1)
    oldest_result = pngfyer.pngfy

    # the following setting changes and result creation should not affect the previous result in any way
    pngfyer.set_vertical_spacing(5)
    most_recent_result = pngfyer.pngfy

    # this is why we pull the Result#settings data after a setting has been changed
    oldest_vertical_spacing = oldest_result.settings.vertical_spacing
    most_recent_vertical_spacing = most_recent_result.settings.vertical_spacing

    refute_equal(oldest_vertical_spacing, most_recent_vertical_spacing)
  end

  def test_that_result_settings_text_returns_the_expected_text_set_previously
    pngfyer.set_text('Drama, baby!')
    expected_returned_text = 'Drama, baby!'
    result = pngfyer.pngfy

    settings_text = result.settings.text

    assert_equal(expected_returned_text, settings_text)
  end

  def test_that_result_settings_set_text_raises_no_method_error
    result = pngfyer.pngfy

    assert_raises(NoMethodError) do
      result.settings.set_text('Whats up doc?')
    end
  end

  def test_that_result_settings_text_reflects_settings_at_result_creation_time_and_not_future_changes
    pngfyer.set_text('Why so serious?')
    oldest_result = pngfyer.pngfy

    # the following setting changes and result creation should not affect the previous result in any way
    pngfyer.set_text('That is none of your business!')
    most_recent_result = pngfyer.pngfy

    # this is why we pull the Result#settings data after a setting has been changed
    oldest_text = oldest_result.settings.text
    most_recent_text = most_recent_result.settings.text

    refute_equal(oldest_text, most_recent_text)
  end

  def test_that_result_png_width_returns_expected_width_for_single_character_text
    # set only the most relevant settings to a biased, reasonable and expected value
    random_horizontal_spacing = rand(0..10)
    random_single_char_text = supported_ascii_characters_without_newline.sample
    expected_png_width = expected_png_width(random_single_char_text, random_horizontal_spacing)

    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_text(random_single_char_text)

    png_width = pngfyer.pngfy.png.width

    assert_equal(expected_png_width, png_width)
  end

  def test_that_result_png_width_returns_expected_width_for_single_line_text
    # set only the most relevant settings to a biased, reasonable and expected value
    random_horizontal_spacing = rand(0..10)
    random_single_line_text = supported_ascii_characters_without_newline.shuffle.join
    expected_png_width = expected_png_width(random_single_line_text, random_horizontal_spacing)

    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_text(random_single_line_text)

    png_width = pngfyer.pngfy.png.width

    assert_equal(expected_png_width, png_width)
  end

  def test_that_result_png_width_returns_expected_width_for_multi_line_text_with_empty_lines
    # set only the most relevant settings to a biased, reasonable and expected value
    random_horizontal_spacing = rand(0..10)
    random_multi_line_text_with_empty_lines = [
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      random_and_shuffled_supported_character_string_without_newlines,
      ''
    ].join("\n")

    expected_png_width = expected_png_width(random_multi_line_text_with_empty_lines, random_horizontal_spacing)

    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_text(random_multi_line_text_with_empty_lines)

    png_width = pngfyer.pngfy.png.width

    assert_equal(expected_png_width, png_width)
  end

  def test_that_result_png_height_returns_expected_height_for_single_character_text
    # set only the most relevant settings to a biased, reasonable and expected value
    random_vertical_spacing = rand(0..10)
    random_single_char_text = supported_ascii_characters_without_newline.sample
    expected_png_height = expected_png_height(random_single_char_text, random_vertical_spacing)

    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_single_char_text)

    png_height = pngfyer.pngfy.png.height

    assert_equal(expected_png_height, png_height)
  end

  def test_that_result_png_height_returns_expected_height_for_single_line_text
    # set only the most relevant settings to a biased, reasonable and expected value
    random_vertical_spacing = rand(0..10)
    random_single_line_text = supported_ascii_characters_without_newline.shuffle.join
    expected_png_height = expected_png_height(random_single_line_text, random_vertical_spacing)

    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_single_line_text)

    png_height = pngfyer.pngfy.png.height

    assert_equal(expected_png_height, png_height)
  end

  def test_that_result_png_height_returns_expected_height_for_multi_line_text_with_empty_lines
    # set only the most relevant settings to a biased, reasonable and expected value
    random_vertical_spacing = rand(0..10)
    random_multi_line_text_with_empty_lines = [
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      random_and_shuffled_supported_character_string_without_newlines,
      ''
    ].join("\n")

    expected_png_height = expected_png_height(random_multi_line_text_with_empty_lines, random_vertical_spacing)

    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_multi_line_text_with_empty_lines)

    png_height = pngfyer.pngfy.png.height

    assert_equal(expected_png_height, png_height)
  end

  def test_that_result_render_width_returns_expected_width_for_single_character_text
    # set only the most relevant settings to a biased, reasonable and expected value
    random_font_height = 9 * rand(1..100)
    random_horizontal_spacing = rand(0..10)
    random_single_char_text = supported_ascii_characters_without_newline.sample
    expected_render_width = expected_render_width(
      random_single_char_text,
      random_horizontal_spacing,
      random_font_height
    )

    pngfyer.set_font_height(random_font_height)
    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_text(random_single_char_text)

    render_width = pngfyer.pngfy.render_width

    assert_equal(expected_render_width, render_width)
  end

  # rubocop:disable Metrics/AbcSize
  def test_that_result_render_width_returns_expected_width_for_single_line_text
    # set only the most relevant settings to a biased, reasonable and expected value
    random_font_height = 9 * rand(1..100)
    random_horizontal_spacing = rand(0..10)
    random_single_line_text = supported_ascii_characters_without_newline.shuffle.join
    expected_render_width = expected_render_width(
      random_single_line_text,
      random_horizontal_spacing,
      random_font_height
    )

    pngfyer.set_font_height(random_font_height)
    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_text(random_single_line_text)

    render_width = pngfyer.pngfy.render_width

    assert_equal(expected_render_width, render_width)
  end

  def test_that_result_render_width_returns_expected_width_for_multi_line_text_with_empty_lines
    # set only the most relevant settings to a biased, reasonable and expected value
    random_font_height = 9 * rand(1..100)
    random_horizontal_spacing = rand(0..10)
    random_multi_line_text_with_empty_lines = [
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      random_and_shuffled_supported_character_string_without_newlines,
      ''
    ].join("\n")

    expected_render_width = expected_render_width(
      random_multi_line_text_with_empty_lines,
      random_horizontal_spacing,
      random_font_height
    )

    pngfyer.set_font_height(random_font_height)
    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_text(random_multi_line_text_with_empty_lines)

    render_width = pngfyer.pngfy.render_width

    assert_equal(expected_render_width, render_width)
  end
  # rubocop:enable Metrics/AbcSize

  def test_that_result_render_height_returns_expected_height_for_single_character_text
    # set only the most relevant settings to a biased, reasonable and expected value
    random_font_height = 9 * rand(1..100)
    random_vertical_spacing = rand(0..10)
    random_single_char_text = supported_ascii_characters_without_newline.sample
    expected_render_height = expected_render_height(
      random_single_char_text,
      random_vertical_spacing,
      random_font_height
    )

    pngfyer.set_font_height(random_font_height)
    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_single_char_text)

    render_height = pngfyer.pngfy.render_height

    assert_equal(expected_render_height, render_height)
  end

  # rubocop:disable Metrics/AbcSize
  def test_that_result_render_height_returns_expected_height_for_single_line_text
    # set only the most relevant settings to a biased, reasonable and expected value
    random_font_height = 9 * rand(1..100)
    random_vertical_spacing = rand(0..10)
    random_single_line_text = supported_ascii_characters_without_newline.shuffle.join
    expected_render_height = expected_render_height(
      random_single_line_text,
      random_vertical_spacing,
      random_font_height
    )

    pngfyer.set_font_height(random_font_height)
    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_single_line_text)

    render_height = pngfyer.pngfy.render_height

    assert_equal(expected_render_height, render_height)
  end

  def test_that_result_render_height_returns_expected_height_for_multi_line_text_with_empty_lines
    # set only the most relevant settings to a biased, reasonable and expected value
    random_font_height = 9 * rand(1..100)
    random_vertical_spacing = rand(0..10)
    random_multi_line_text_with_empty_lines = [
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      random_and_shuffled_supported_character_string_without_newlines,
      ''
    ].join("\n")

    expected_render_height = expected_render_height(
      random_multi_line_text_with_empty_lines,
      random_vertical_spacing,
      random_font_height
    )

    pngfyer.set_font_height(random_font_height)
    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_multi_line_text_with_empty_lines)

    render_height = pngfyer.pngfy.render_height

    assert_equal(expected_render_height, render_height)
  end

  def test_that_result_png_contains_settings_font_color_in_font_character_regions_for_single_character_text
    # set only the most relevant settings to a biased, reasonable and expected value
    random_horizontal_spacing = rand(0..10)
    random_vertical_spacing = rand(0..10)
    random_single_char_text = supported_ascii_characters_without_newline.sample

    # background color components should contrast the font color components
    pngfyer.set_font_color(red: 255, green: 255, blue: 255, alpha: 255)
    pngfyer.set_background_color(red: 11, green: 22, blue: 33, alpha: 44)
    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_single_char_text)

    result = pngfyer.pngfy
    settings = result.settings
    expected_font_color_as_integer = color_rgba_to_chunky_png_color_integer(settings.font_color)
    png = result.png

    font_region_pixel_color_enum = each_font_region_pixel_with_color_enumerator(
      settings.text,
      settings.horizontal_spacing,
      settings.vertical_spacing,
      png
    )

    font_region_pixel_color_enum.each do |_font_pixel_x, _font_pixel_y, font_pixel_color_as_integer|
      assert_equal(expected_font_color_as_integer, font_pixel_color_as_integer)
    end
  end

  def test_that_result_png_contains_settings_font_color_in_font_character_regions_for_single_line_text
    # set only the most relevant settings to a biased, reasonable and expected value
    random_horizontal_spacing = rand(0..10)
    random_vertical_spacing = rand(0..10)
    random_single_line_text = supported_ascii_characters_without_newline.shuffle.join

    # background color components should contrast the font color components
    pngfyer.set_font_color(red: 200, green: 200, blue: 200, alpha: 255)
    pngfyer.set_background_color(red: 6, green: 12, blue: 18, alpha: 36)
    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_single_line_text)

    result = pngfyer.pngfy
    settings = result.settings
    expected_font_color_as_integer = color_rgba_to_chunky_png_color_integer(settings.font_color)
    png = result.png

    font_region_pixel_color_enum = each_font_region_pixel_with_color_enumerator(
      settings.text,
      settings.horizontal_spacing,
      settings.vertical_spacing,
      png
    )

    font_region_pixel_color_enum.each do |_font_pixel_x, _font_pixel_y, font_pixel_color_as_integer|
      assert_equal(expected_font_color_as_integer, font_pixel_color_as_integer)
    end
  end

  def test_that_result_png_contains_settings_font_color_in_font_character_regions_for_multi_line_text_with_empty_lines
    # set only the most relevant settings to a biased, reasonable and expected value
    random_horizontal_spacing = rand(0..10)
    random_vertical_spacing = rand(0..10)
    random_multi_line_text_with_empty_lines = [
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      random_and_shuffled_supported_character_string_without_newlines,
      ''
    ].join("\n")

    # background color components should contrast the font color components
    pngfyer.set_font_color(red: 200, green: 200, blue: 200, alpha: 255)
    pngfyer.set_background_color(red: 2, green: 4, blue: 8, alpha: 10)
    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_multi_line_text_with_empty_lines)

    result = pngfyer.pngfy
    settings = result.settings
    expected_font_color_as_integer = color_rgba_to_chunky_png_color_integer(settings.font_color)
    png = result.png

    font_region_pixel_color_enum = each_font_region_pixel_with_color_enumerator(
      settings.text,
      settings.horizontal_spacing,
      settings.vertical_spacing,
      png
    )

    font_region_pixel_color_enum.each do |_font_pixel_x, _font_pixel_y, font_pixel_color_as_integer|
      assert_equal(expected_font_color_as_integer, font_pixel_color_as_integer)
    end
  end

  def test_that_result_png_contains_settings_font_color_in_font_character_regions_when_font_color_fully_opaque
    # set only the most relevant settings to a biased, reasonable and expected value
    random_horizontal_spacing = rand(0..10)
    random_vertical_spacing = rand(0..10)
    random_multi_line_text_with_empty_lines = [
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      random_and_shuffled_supported_character_string_without_newlines,
      ''
    ].join("\n")

    # background color components should contrast the font color components
    pngfyer.set_font_color(red: 75, green: 150, blue: 225, alpha: 255)
    pngfyer.set_background_color(red: 15, green: 25, blue: 35, alpha: 125)
    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_multi_line_text_with_empty_lines)

    result = pngfyer.pngfy
    settings = result.settings
    expected_font_color_as_integer = color_rgba_to_chunky_png_color_integer(settings.font_color)
    png = result.png

    font_region_pixel_color_enum = each_font_region_pixel_with_color_enumerator(
      settings.text,
      settings.horizontal_spacing,
      settings.vertical_spacing,
      png
    )

    font_region_pixel_color_enum.each do |_font_pixel_x, _font_pixel_y, font_pixel_color_as_integer|
      assert_equal(expected_font_color_as_integer, font_pixel_color_as_integer)
    end
  end

  def test_that_result_png_contains_alpha_composited_color_in_font_character_regions_when_font_color_transparent
    # set only the most relevant settings to a biased, reasonable and expected value
    random_horizontal_spacing = rand(0..10)
    random_vertical_spacing = rand(0..10)
    random_multi_line_text_with_empty_lines = [
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      random_and_shuffled_supported_character_string_without_newlines,
      ''
    ].join("\n")

    # background color components should contrast the font color components
    pngfyer.set_font_color(red: 0, green: 255, blue: 0, alpha: 153)
    pngfyer.set_background_color(red: 255, green: 0, blue: 0, alpha: 255)
    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_multi_line_text_with_empty_lines)

    result = pngfyer.pngfy
    settings = result.settings
    expected_color = color_rgba_alpha_composite(settings.font_color, settings.background_color)
    expected_font_color_as_integer = color_rgba_to_chunky_png_color_integer(expected_color)
    png = result.png

    font_region_pixel_color_enum = each_font_region_pixel_with_color_enumerator(
      settings.text,
      settings.horizontal_spacing,
      settings.vertical_spacing,
      png
    )

    font_region_pixel_color_enum.each do |_font_pixel_x, _font_pixel_y, font_pixel_color_as_integer|
      assert_equal(expected_font_color_as_integer, font_pixel_color_as_integer)
    end
  end

  def test_that_result_png_contains_settings_background_color_outside_font_character_regions_for_single_character_text
    # set only the most relevant settings to a biased, reasonable and expected value
    random_horizontal_spacing = rand(0..10)
    random_vertical_spacing = rand(0..10)
    random_single_char_text = supported_ascii_characters_without_newline.sample

    # background color components should contrast the font color components
    pngfyer.set_font_color(red: 255, green: 255, blue: 255, alpha: 255)
    pngfyer.set_background_color(red: 11, green: 22, blue: 33, alpha: 44)
    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_single_char_text)

    result = pngfyer.pngfy
    settings = result.settings
    expected_background_color_as_integer = color_rgba_to_chunky_png_color_integer(settings.background_color)
    png = result.png

    background_region_pixel_color_enum = each_background_region_pixel_with_color_enumerator(
      settings.text,
      settings.horizontal_spacing,
      settings.vertical_spacing,
      png
    )

    background_region_pixel_color_enum.each do |_bg_pixel_x, _bg_pixel_y, background_pixel_color_as_integer|
      assert_equal(expected_background_color_as_integer, background_pixel_color_as_integer)
    end
  end

  def test_that_result_png_contains_settings_background_color_outside_font_character_regions_for_single_line_text
    # set only the most relevant settings to a biased, reasonable and expected value
    random_horizontal_spacing = rand(0..10)
    random_vertical_spacing = rand(0..10)
    random_single_line_text = supported_ascii_characters_without_newline.shuffle.join

    # background color components should contrast the font color components
    pngfyer.set_font_color(red: 200, green: 200, blue: 200, alpha: 255)
    pngfyer.set_background_color(red: 6, green: 12, blue: 18, alpha: 36)
    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_single_line_text)

    result = pngfyer.pngfy
    settings = result.settings
    expected_background_color_as_integer = color_rgba_to_chunky_png_color_integer(settings.background_color)
    png = result.png

    background_region_pixel_color_enum = each_background_region_pixel_with_color_enumerator(
      settings.text,
      settings.horizontal_spacing,
      settings.vertical_spacing,
      png
    )

    background_region_pixel_color_enum.each do |_bg_pixel_x, _bg_pixel_y, background_pixel_color_as_integer|
      assert_equal(expected_background_color_as_integer, background_pixel_color_as_integer)
    end
  end

  # rubocop:disable Layout/LineLength
  def test_that_result_png_contains_settings_background_color_outside_font_character_regions_for_multi_line_text_with_empty_lines
    # set only the most relevant settings to a biased, reasonable and expected value
    random_horizontal_spacing = rand(0..10)
    random_vertical_spacing = rand(0..10)
    random_multi_line_text_with_empty_lines = [
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      '',
      random_and_shuffled_supported_character_string_without_newlines,
      random_and_shuffled_supported_character_string_without_newlines,
      ''
    ].join("\n")

    # background color components should contrast the font color components
    pngfyer.set_font_color(red: 200, green: 200, blue: 200, alpha: 255)
    pngfyer.set_background_color(red: 2, green: 4, blue: 8, alpha: 10)
    pngfyer.set_horizontal_spacing(random_horizontal_spacing)
    pngfyer.set_vertical_spacing(random_vertical_spacing)
    pngfyer.set_text(random_multi_line_text_with_empty_lines)

    result = pngfyer.pngfy
    settings = result.settings
    expected_background_color_as_integer = color_rgba_to_chunky_png_color_integer(settings.background_color)
    png = result.png

    background_region_pixel_color_enum = each_background_region_pixel_with_color_enumerator(
      settings.text,
      settings.horizontal_spacing,
      settings.vertical_spacing,
      png
    )

    background_region_pixel_color_enum.each do |_bg_pixel_x, _bg_pixel_y, background_pixel_color_as_integer|
      assert_equal(expected_background_color_as_integer, background_pixel_color_as_integer)
    end
  end
  # rubocop:enable Metrics/AbcSize, Layout/LineLength

  def test_that_result_png_is_5_pixels_wide_for_every_supported_non_control_character_as_single_char_text
    supported_ascii_characters_without_newline.each do |supported_ascii_character|
      # set only text setting per iterated supported ascii character
      pngfyer.set_text(supported_ascii_character)

      result_png = pngfyer.pngfy.png

      assert_equal(5, result_png.width)
    end
  end

  def test_that_result_png_is_9_pixels_high_for_every_supported_non_control_character_as_single_char_text
    supported_ascii_characters_without_newline.each do |supported_ascii_character|
      # set only text setting per iterated supported ascii character
      pngfyer.set_text(supported_ascii_character)

      result_png = pngfyer.pngfy.png

      assert_equal(9, result_png.height)
    end
  end

  # rubocop: disable Metrics/AbcSize
  def test_that_result_png_pixels_mirror_the_glyph_design_precisely_for_every_supported_non_control_character
    # to make that the glyph designs are accurately represented by the result png, we generate a
    # result png for every single supported non-control character through a single character text
    #
    # this makes it easy to test that the result png contains the correct pixel data because the
    # png and the glyph design have the same resolution of 5x9 pixels at this point

    # set only the most relevant settings to a biased, reasonable and expected value that are the same
    # for all the iterated supported characters
    design_pngfyer.set_font_color(red: 0, green: 255, blue: 0, alpha: 255)
    design_pngfyer.set_background_color(red: 255, green: 0, blue: 0, alpha: 255)

    supported_ascii_characters_without_newline.each do |supported_ascii_character|
      # set only text setting per iterated supported ascii character
      design_pngfyer.set_text(supported_ascii_character)

      result = design_pngfyer.pngfy
      settings = result.settings
      glyph_design_string = AsciiPngfy::Glyphs::DESIGNS[supported_ascii_character]
      png = result.png

      # check that png contents and glyph design exactly mirror each other in terms of their contexts
      # which are the glyph design in terms of the 45 character string and the 5x9 pixel png
      #
      # use the region iteration we already implemented so we can iterate through the all png
      # pixel coordinates from the top row to the bottom row, each row left to right and scan the
      # string accordingly
      #
      # this way the design string can be defined so that 9 lines of 5 characters look exactly as the
      # png is supposed to render the glyph, which means the design can be made through these strings
      # and the design will be properly replicated in the Result#png
      png_region = generate_png_region(png)

      glyph_design_pixel_index = 0
      png_region.each_pixel do |png_pixel_x, png_pixel_y|
        png_pixel_color_as_integer = png[png_pixel_x, png_pixel_y]

        # test that the glyph design characters map over correctly to the png
        glyph_design_pixel_character = glyph_design_string[glyph_design_pixel_index]
        glyph_design_pixel_index += 1

        # decide which color to expect in png based on wether glyph design pixel character is font or background layer
        expected_png_pixel_color =
          if AsciiPngfy::Glyphs.font_layer_design_character?(glyph_design_pixel_character)
            settings.font_color
          elsif AsciiPngfy::Glyphs.background_layer_design_character?(glyph_design_pixel_character)
            settings.background_color
          end
        expected_png_pixel_color_as_integer = color_rgba_to_chunky_png_color_integer(expected_png_pixel_color)

        assert_equal(expected_png_pixel_color_as_integer, png_pixel_color_as_integer)
      end
    end
  end
  # rubocop: enable Metrics/AbcSize

  private

  def random_and_shuffled_supported_character_string_without_newlines
    random_length = rand(1..supported_ascii_characters.size)
    supported_ascii_characters_without_newline.sample(random_length).shuffle.join
  end

  def text_lines(text)
    text.split("\n", -1)
  end

  def longest_line_length(text_lines)
    text_lines.max_by(&:length).length
  end

  def expected_png_width(text, horizontal_spacing)
    text_lines = text_lines(text)
    longest_line_length = longest_line_length(text_lines)
    horizontal_spacing_count = longest_line_length - 1

    (longest_line_length * 5) + (horizontal_spacing_count * horizontal_spacing)
  end

  def expected_png_height(text, vertical_spacing)
    text_lines = text_lines(text)
    text_line_count = text_lines.size
    vertical_spacing_count = text_line_count - 1

    (text_line_count * 9) + (vertical_spacing_count * vertical_spacing)
  end

  def font_height_multiplier(font_height)
    font_height / 9
  end

  def expected_render_width(text, horizontal_spacing, font_height)
    png_width = expected_png_width(text, horizontal_spacing)
    png_width * font_height_multiplier(font_height)
  end

  def expected_render_height(text, vertical_spacing, font_height)
    png_height = expected_png_height(text, vertical_spacing)
    png_height * font_height_multiplier(font_height)
  end

  def text_lines_characters(text)
    text_lines(text).map(&:chars)
  end

  def generate_font_regions(text, horizontal_spacing, vertical_spacing)
    font_regions = []
    text_lines_characters = text_lines_characters(text)

    text_lines_characters.each_with_index do |line_characters, row_index|
      line_characters.each_with_index do |_character, column_index|
        font_region_top_left_x = column_index * (horizontal_spacing + 5)
        font_region_top_left_y = row_index * (vertical_spacing + 9)
        font_region_bottom_right_x = font_region_top_left_x + (5 - 1)
        font_region_bottom_right_y = font_region_top_left_y + (9 - 1)

        font_regions << Helpers::AABB.new(
          font_region_top_left_x,
          font_region_top_left_y,
          font_region_bottom_right_x,
          font_region_bottom_right_y
        )
      end
    end

    font_regions
  end

  def color_rgba_to_chunky_png_color_integer(color_rgba)
    ChunkyPNG::Color.rgba(color_rgba.red, color_rgba.green, color_rgba.blue, color_rgba.alpha)
  end

  def each_font_region_pixel_with_color_enumerator(text, horizontal_spacing, vertical_spacing, png)
    font_regions = generate_font_regions(text, horizontal_spacing, vertical_spacing)

    Enumerator.new do |yielder|
      font_regions.each do |font_region|
        font_region.each_pixel do |font_pixel_x, font_pixel_y|
          font_region_pixel_color_as_integer = png[font_pixel_x, font_pixel_y]

          yielder << [font_pixel_x, font_pixel_y, font_region_pixel_color_as_integer]
        end
      end
    end
  end

  def generate_png_region(png)
    Helpers::AABB.new(0, 0, png.width - 1, png.height - 1)
  end

  def each_background_region_pixel_with_color_enumerator(text, horizontal_spacing, vertical_spacing, png)
    # to determine background pixels, naively iterate through each png pixel and ignore each pixel
    # that overlaps with any of the determined font regions so the bacground pixels are essentially
    # computed as: background region = (png region - font regions)

    font_regions = generate_font_regions(text, horizontal_spacing, vertical_spacing)
    png_region = generate_png_region(png)

    Enumerator.new do |yielder|
      png_region.each_pixel do |png_pixel_x, png_pixel_y|
        # the png region coordinates are not background if the coordinates overlap any font region
        is_background_pixel = font_regions.none? do |font_region|
          font_region.overlaps_coordinates?(png_pixel_x, png_pixel_y)
        end

        next unless is_background_pixel

        background_region_pixel_color_as_integer = png[png_pixel_x, png_pixel_y]
        yielder << [png_pixel_x, png_pixel_y, background_region_pixel_color_as_integer]
      end
    end
  end

  def straight_alpha_color_composition(over_component, over_alpha, under_component, under_alpha)
    # assume that both component and alpha values are passed in the range (0..255)
    # make sure to interpret the algorithm correctly with regards to rounding errors
    # scaling color component values by floats and then converting back to integers gives
    # bad accuracy of the actual composited color component value as a lot of information
    # is potentially lost because of discarded color component fractions
    ca = over_component
    aa = over_alpha.fdiv(255)
    cb = under_component
    ab = under_alpha.fdiv(255)

    # color component result as integer in range 0..255
    ((ca * aa + cb * ab * (1 - aa)) / (aa + ab * (1 - aa))).to_i
  end

  def straight_alpha_transparency_composition(over_alpha, under_alpha)
    aa = over_alpha.fdiv(255)
    ab = under_alpha.fdiv(255)

    # alpha commponent result as integer in range 0..255
    ((aa + ab * (1 - aa)) * 255).to_i
  end

  def color_rgba_alpha_composite(over_color, under_color)
    over_color_alpha = over_color.alpha
    under_color_alpha = under_color.alpha

    AsciiPngfy::ColorRGBA.new(
      straight_alpha_color_composition(over_color.red, over_color_alpha, under_color.red, under_color_alpha),
      straight_alpha_color_composition(over_color.green, over_color_alpha, under_color.green, under_color_alpha),
      straight_alpha_color_composition(over_color.blue, over_color_alpha, under_color.blue, under_color_alpha),
      straight_alpha_transparency_composition(over_color_alpha, under_color_alpha)
    )
  end
end
# rubocop:enable Metrics/ClassLength, Metrics/MethodLength
