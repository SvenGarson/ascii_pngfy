# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - Uses RenderingRules to interpret settings into a Result object
  #   - Uses Glyph designs to plot design data into the result png
  class SettingsRenderer
    def initialize(use_glyph_designs: true)
      self.use_glyph_designs = use_glyph_designs
    end

    def render_result(settings_snapshot)
      png = generate_png(settings_snapshot)

      RenderingRules.plot_settings(settings_snapshot, use_glyph_designs, png)

      generate_result(settings_snapshot, png)
    end

    private

    def generate_png(settings)
      ChunkyPNG::Image.new(
        RenderingRules.png_width(settings),
        RenderingRules.png_height(settings),
        RenderingRules.color_rgba_to_chunky_png_integer(settings.background_color)
      )
    end

    def generate_result(settings, png)
      Result.new(
        png,
        RenderingRules.render_width(settings),
        RenderingRules.render_height(settings),
        settings
      )
    end

    attr_accessor(:use_glyph_designs)
  end
end
