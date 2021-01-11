# frozen_string_literal: true

module AsciiPngfy
  # Settings only here for testing
  # more it to another file
  class Settings
    attr_accessor(:font_color)

    def initialize
      @font_color = ColorRGBA.new(255, 255, 255, 255)
    end

    def set_font_color(red: nil, green: nil, blue: nil, alpha: nil)
      @font_color.red = red unless red.nil?
      @font_color.green = green unless green.nil?
      @font_color.blue = blue unless blue.nil?
      @font_color.alpha = alpha unless alpha.nil?

      @font_color.dup
    end
  end

  # Reponsibilities
  #   - Provide the complete interface of this gem
  #   - References settings and pipe user setting calls
  #     to the appropriate setting implementation
  #   - Provides the renderer with the settings for 'pngfication'
  class Pngfyer
    attr_accessor(:settings)

    def initialize
      @settings = Settings.new
    end

    def set_font_color(red: nil, green: nil, blue: nil, alpha: nil)
      @settings.set_font_color(red: red, green: green, blue: blue, alpha: alpha)
    end
  end
end
