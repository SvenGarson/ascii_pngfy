# frozen_string_literal: true

module AsciiPngfy
  # Provides simple RGBA color hanlding
  class ColorRGBA
    attr_reader(:red, :green, :blue, :alpha)

    def initialize(red, green, blue, alpha)
      @red = red
      @green = green
      @blue = blue
      @alpha = alpha
    end
  end
end
