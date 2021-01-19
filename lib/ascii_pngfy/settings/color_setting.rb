# frozen_string_literal: true

module AsciiPngfy
  module Settings
    # Reponsibilities
    #   - Keeps track of the color setting(s)
    #   - Validated through ColorRGBA implicitly
    class ColorSetting
      include SetableGetable

      def initialize(initial_red, initial_green, initial_blue, initial_alpha)
        self.color = AsciiPngfy::ColorRGBA.new(0, 0, 0, 0)

        set(
          red: initial_red,
          green: initial_green,
          blue: initial_blue,
          alpha: initial_alpha
        )
      end

      def get
        color.dup
      end

      def set(red: nil, green: nil, blue: nil, alpha: nil)
        color.red = red unless red.nil?
        color.green = green unless green.nil?
        color.blue = blue unless blue.nil?
        color.alpha = alpha unless alpha.nil?

        color.dup
      end

      private

      attr_accessor(:color)
    end
  end
end
