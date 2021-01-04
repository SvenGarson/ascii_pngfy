# frozen_string_literal: true

module AsciiPngfy
  # Keeps track and provides interface to the Rendering settings
  # such as color; spacing and font height
  class RendererSettings
    attr_accessor(:font_color)

    def initialize
      # initialize rendering attributes here
      self.font_color = ColorRGBA.new(255, 255, 255, 255)
    end
  end
end
