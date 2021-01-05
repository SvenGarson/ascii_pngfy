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
      settings.font_color.red = red unless red.nil?
      settings.font_color.green = green unless green.nil?
      settings.font_color.blue = blue unless blue.nil?
      settings.font_color.alpha = alpha unless alpha.nil?
    end

    private

    attr_accessor(:settings)
  end
end
