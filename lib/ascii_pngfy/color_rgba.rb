# frozen_string_literal: true

module AsciiPngfy
  # Provides simple RGBA color hanlding
  class ColorRGBA
    VALID_RGBA_COLOR_RANGE = (0..255).freeze
    attr_reader(:red, :green, :blue, :alpha)

    def initialize(red, green, blue, alpha)
      self.red = red
      self.green = green
      self.blue = blue
      self.alpha = alpha
    end

    def red=(new_red)
      @red = validate_color_value(new_red)
    end

    def green=(new_green)
      @green = validate_color_value(new_green)
    end

    def blue=(new_blue)
      @blue = validate_color_value(new_blue)
    end

    def alpha=(new_alpha)
      @alpha = validate_color_value(new_alpha)
    end

    def ==(other)
      other.red == red &&
        other.green == green &&
        other.blue == blue &&
        other.alpha == alpha
    end

    private

    def validate_color_value(color_value)
      return color_value if valid_color_value?(color_value)

      raise Exceptions::InvalidRGBAColorValueError, color_value
    end

    def valid_color_value?(color_value)
      color_value.is_a?(Integer) && VALID_RGBA_COLOR_RANGE.cover?(color_value)
    end
  end
end
