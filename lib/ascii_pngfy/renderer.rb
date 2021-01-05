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

      current_font_color.red = red unless red.nil?
      current_font_color.green = green unless green.nil?
      current_font_color.blue = blue unless blue.nil?
      current_font_color.alpha = alpha unless alpha.nil?

      current_font_color.dup
    end

    private

    attr_accessor(:settings)
  end
end
