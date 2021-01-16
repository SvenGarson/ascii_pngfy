# frozen_string_literal: true

module AsciiPngfy
  module Settings
    # Reponsibilities
    #   - Keeps track of the the horizontal_spacing setting
    #   - Validates horizontal_spacing
    class HorizontalSpacingSetting
      def initialize(initial_spacing)
        self.horizontal_spacing = initial_spacing
      end

      def get
        horizontal_spacing
      end

      def set(desired_spacing)
        validated_horizontal_spacing = validate_horizontal_spacing(desired_spacing)

        self.horizontal_spacing = validated_horizontal_spacing
      end

      private

      attr_accessor(:horizontal_spacing)

      def horizontal_spacing_valid?(some_spacing)
        some_spacing.is_a?(Integer) && (some_spacing >= 0)
      end

      def validate_horizontal_spacing(some_spacing)
        return some_spacing if horizontal_spacing_valid?(some_spacing)

        error_message = String.new
        error_message << "#{some_spacing} is not a valid horizontal spacing. "
        error_message << 'Must be an Integer in the range (0..).'

        raise AsciiPngfy::Exceptions::InvalidHorizontalSpacingError, error_message
      end
    end
  end
end
