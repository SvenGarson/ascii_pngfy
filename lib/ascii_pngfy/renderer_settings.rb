# frozen_string_literal: true

module AsciiPngfy
  # Keeps track and provides interface to the Rendering settings
  # such as color; spacing and font height
  class RendererSettings
    attr_accessor(
      :font_color,
      :background_color,
      :font_size,
      :horizontal_spacing,
      :vertical_spacing
    )

    def initialize
      # initialize rendering attributes here
      self.font_color = ColorRGBA.new(255, 255, 255, 255)
      self.background_color = ColorRGBA.new(0, 0, 0, 0)
      self.font_size = 9
      self.horizontal_spacing = 1
      self.vertical_spacing = 1
    end
  end
end
