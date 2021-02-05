# frozen_string_literal: true

require 'chunky_png'

module AsciiPngfy
  # Reponsibilities
  #   > Provides acces to Result data points, which are
  #     - generated png as ChunkyPNG::Image instance
  #     - render width and height
  #     - settings snapshot that supports only setting getters
  class Result
    attr_reader(:png, :render_width, :render_height, :settings)

    def initialize(png, render_width, render_height, settings_snapshot)
      self.png = png
      self.render_width = render_width
      self.render_height = render_height
      self.settings = settings_snapshot
    end

    private

    attr_writer(:png, :render_width, :render_height, :settings)
  end
end
