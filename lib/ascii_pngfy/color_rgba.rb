# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - Provides RGBA color handling and validation
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
      @red = validate_color_value(new_red, :red)
    end

    def green=(new_green)
      @green = validate_color_value(new_green, :green)
    end

    def blue=(new_blue)
      @blue = validate_color_value(new_blue, :blue)
    end

    def alpha=(new_alpha)
      @alpha = validate_color_value(new_alpha, :alpha)
    end

    def ==(other)
      other.red == red &&
        other.green == green &&
        other.blue == blue &&
        other.alpha == alpha
    end

    private

    def validate_color_value(color_value, color_component)
      return color_value if valid_color_value?(color_value)

      error_message = String.new
      error_message << "#{color_value.inspect} is not a valid #{color_component} color component value. "
      error_message << "Must be an Integer in the range (#{VALID_RGBA_COLOR_RANGE})."

      raise Exceptions::InvalidRGBAColorValueError, error_message
    end

    def valid_color_value?(color_value)
      color_value.is_a?(Integer) && VALID_RGBA_COLOR_RANGE.cover?(color_value)
    end
  end
end
