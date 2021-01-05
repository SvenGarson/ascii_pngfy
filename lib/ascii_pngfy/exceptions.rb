# frozen_string_literal: true

module AsciiPngfy
  # Provides a custom AsciiPngfy Exceptions/Error hierarchy
  module Exceptions
    # Base class to classify AsciiPngfy errors under StandardError
    class AsciiPngfyError < StandardError; end

    # git stat
    class InvalidRGBAColorValueError < AsciiPngfyError
      def initialize(color_value)
        # it would be easier to just pass the error since when raising it,
        # in the concerned module, we know what it is about, and dont know
        # about this here.
        #
        # So just pass it, don't be 'smart' about it.
        super("#{color_value} is not a valid RGBA value apparently...")
      end
    end
  end
end
