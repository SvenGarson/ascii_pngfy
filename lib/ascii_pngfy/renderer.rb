# frozen_string_literal: true

module AsciiPngfy
  # Provides the interface to:
  #  - wrapped rendering setting definition
  #  - texture and usage meta-information generation
  class Renderer
    def initialize
      self.settings = RendererSettings.new
    end

    def set_font_color(red: nil, green: nil, blue: nil, alpha: nil)
      current_font_color = settings.font_color

      set_color_components(red, green, blue, alpha, current_font_color)

      current_font_color.dup
    end

    def set_background_color(red: nil, green: nil, blue: nil, alpha: nil)
      current_background_color = settings.background_color

      set_color_components(red, green, blue, alpha, current_background_color)

      current_background_color.dup
    end

    private

    def set_color_components(red, green, blue, alpha, color)
      color.red = red unless red.nil?
      color.green = green unless green.nil?
      color.blue = blue unless blue.nil?
      color.alpha = alpha unless alpha.nil?
    end

    attr_accessor(:settings)
  end
end
