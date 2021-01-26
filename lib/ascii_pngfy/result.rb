# frozen_string_literal: true

require 'chunky_png'

module AsciiPngfy
  # Reponsibilities
  #   > Provides access to the following data points
  #       - generated png along with all of the png#* methods
  #         provided by chunky_png
  #       - render dimensions
  #       - snapshot of settings used for a particular result
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
