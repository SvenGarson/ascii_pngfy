# frozen_string_literal: true

module AsciiPngfy
  # Keeps track and provides interface to the Rendering settings
  # such as color; spacing and font height
  class RendererSettings
    attr_accessor(
      :font_color,
      :background_color,
      :font_height,
      :horizontal_spacing,
      :vertical_spacing
    )

    def initialize
      # initialize rendering attributes here
      self.font_color = ColorRGBA.new(255, 255, 255, 255)
      self.background_color = ColorRGBA.new(0, 0, 0, 255)
      self.font_height = 9
      self.horizontal_spacing = 1
      self.vertical_spacing = 1
    end
  end
end
