# frozen_string_literal: true

require 'chunky_png'

module AsciiPngfy
  # Reponsibilities
  #   > Provides access to the following data points
  #       - generated png
  #       - render dimensions
  #       - settings used
  class Result
    attr_reader(:settings)

    def initialize(settings)
      @settings = settings
    end

    def png
      ChunkyPNG::Image.new(167, 31, ChunkyPNG::Color::TRANSPARENT)
    end

    def render_width
      501
    end

    def render_height
      93
    end
  end
end
