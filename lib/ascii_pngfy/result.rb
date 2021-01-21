# frozen_string_literal: true
require 'chunky_png'

module AsciiPngfy
  # Reponsibilities
  #   > Provides access to the following data points
  #       - generated png
  #       - render dimensions
  #       - settings used
  class Result
    def png
      ChunkyPNG::Image.new(167, 31, ChunkyPNG::Color::TRANSPARENT)
    end

    def render_width
      0
    end
  end
end
