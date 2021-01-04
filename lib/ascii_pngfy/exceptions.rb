# frozen_string_literal: true

module AsciiPngfy
  # Provides a custom AsciiPngfy Exceptions/Error hierarchy
  module Exceptions
    # Base class to classify AsciiPngfy errors under StandardError
    class AsciiPngfyError < StandardError; end

    class InvalidRGBAColorValueError < AsciiPngfyError
      def initialize(color_value)
        super("#{color_value} is not a valid RGBA value apparently...")
      end
    end
  end
end
