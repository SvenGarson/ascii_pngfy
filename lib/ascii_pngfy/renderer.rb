# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - generate result object from the Pngfyer settings
  class SettingsRenderer
    def initialize(settings_snapshot)
      @settings = settings_snapshot
    end

    def render_result
      # png width
      longest_text_line_length = settings.text.split("\n", -1).max_by(&:length).length
      horizontal_spacing_count = longest_text_line_length - 1
      png_width = (longest_text_line_length * 5) + (horizontal_spacing_count * settings.horizontal_spacing)

      # return Result object
      png = ChunkyPNG::Image.new(png_width, 31, ChunkyPNG::Color::TRANSPARENT)
      render_width = 501
      render_height = 93
      settings = @settings
      Result.new(png, render_width, render_height, settings)
    end

    private

    attr_accessor(:settings)
  end
end
