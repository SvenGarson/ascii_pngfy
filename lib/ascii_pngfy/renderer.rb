# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - generate result object from the Pngfyer settings
  class SettingsRenderer
    def initialize(settings_snapshot)
      @settings = settings_snapshot
    end

    def render_result
      # return Result object
      png = ChunkyPNG::Image.new(
        determine_png_width,
        determine_png_height,
        ChunkyPNG::Color::TRANSPARENT
      )

      Result.new(png, determine_render_width, determine_render_height, settings)
    end

    private

    def text_lines
      settings.text.split("\n", -1)
    end

    def determine_png_width
      longest_text_line_length = text_lines.max_by(&:length).length
      horizontal_spacing_count = longest_text_line_length - 1

      (longest_text_line_length * 5) + (horizontal_spacing_count * settings.horizontal_spacing)
    end

    def determine_png_height
      text_line_count = text_lines.size
      vertical_spacing_count = text_line_count - 1
      (text_line_count * 9) + (vertical_spacing_count * settings.vertical_spacing)
    end

    def determine_font_multiplier
      settings.font_height / 9
    end

    def determine_render_width
      determine_png_width * determine_font_multiplier
    end

    def determine_render_height
      determine_png_height * determine_font_multiplier
    end

    attr_accessor(:settings)
  end
end
