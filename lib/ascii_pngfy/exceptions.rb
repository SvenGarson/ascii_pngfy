# frozen_string_literal: true

module AsciiPngfy
  # Provides a custom AsciiPngfy Exceptions/Error hierarchy
  module Exceptions
    # Base class to classify AsciiPngfy errors under StandardError
    class AsciiPngfyError < StandardError; end

    class InvalidRGBAColorValueError < AsciiPngfyError; end

    class InvalidFontHeightError < AsciiPngfyError; end

    class InvalidHorizontalSpacingError < AsciiPngfyError; end
  end
end
