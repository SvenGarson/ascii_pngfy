# frozen_string_literal: true

require_relative 'testing_prerequisites'

# rubocop:disable Metrics/ClassLength, Metrics/MethodLength
class TestResult < Minitest::Test
  attr_reader(
    :pngfyer,
    :supported_ascii_characters,
    :supported_ascii_characters_without_newline
  )

  def setup
    @pngfyer = AsciiPngfy::Pngfyer.new
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

  def test_that_result_png_width_returns_expected_width_for_multi_line_text_that_contains_empty_lines
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

  def test_that_result_png_height_returns_expected_height_for_multi_line_text_that_contains_empty_lines
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

  def test_that_result_render_width_returns_expected_width_for_multi_line_text_that_contains_empty_lines
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

  def expected_render_width(text, horizontal_spacing, font_height)
    png_width = expected_png_width(text, horizontal_spacing)
    font_height_multiplier = font_height / 9
    png_width * font_height_multiplier
  end
end
# rubocop:enable Metrics/ClassLength, Metrics/MethodLength
