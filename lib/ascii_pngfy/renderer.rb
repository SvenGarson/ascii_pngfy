# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - generate result object from the Pngfyer settings
  class SettingsRenderer
    def initialize(settings_snapshot)
      @settings = settings_snapshot
    end

    def render_result
      png_width = determine_png_width(settings.text, settings.horizontal_spacing)
      png_height = determine_png_height(settings.text, settings.vertical_spacing)

      # return Result object
      png = ChunkyPNG::Image.new(png_width, png_height, ChunkyPNG::Color::TRANSPARENT)
      render_width = 501
      render_height = 93
      settings = @settings
      Result.new(png, render_width, render_height, settings)
    end

    private

    def text_lines(text)
      text.split("\n", -1)
    end

    def determine_png_width(text, horizontal_spacing)
      text_lines = text_lines(text)
      longest_text_line_length = text_lines.max_by(&:length).length
      horizontal_spacing_count = longest_text_line_length - 1

      (longest_text_line_length * 5) + (horizontal_spacing_count * horizontal_spacing)
    end

    def determine_png_height(text, vertical_spacing)
      text_line_count = text_lines(text).size
      vertical_spacing_count = text_line_count - 1
      (text_line_count * 9) + (vertical_spacing_count * vertical_spacing)
    end

    attr_accessor(:settings)
  end
end
