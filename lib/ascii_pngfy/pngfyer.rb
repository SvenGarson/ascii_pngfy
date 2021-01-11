# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - Provide the complete interface of this gem
  #   - References settings and pipe user setting calls
  #     to the appropriate setting if the are defined
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
