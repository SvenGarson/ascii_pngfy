# frozen_string_literal: true

module AsciiPngfy
  module Settings
    # Reponsibilities
    #   - Keeps track of the the vertical_spacing setting
    #   - Validates vertical_spacing
    class VerticalSpacingSetting
      include SetableGetable

      def initialize(initial_spacing)
        self.vertical_spacing = initial_spacing
      end

      def get
        vertical_spacing
      end

      def set(desired_spacing)
        validated_vertical_spacing = validate_vertical_spacing(desired_spacing)

        self.vertical_spacing = validated_vertical_spacing
      end

      private

      attr_accessor(:vertical_spacing)

      def vertical_spacing_valid?(some_spacing)
        some_spacing.is_a?(Integer) && (some_spacing >= 0)
      end

      def validate_vertical_spacing(some_spacing)
        return some_spacing if vertical_spacing_valid?(some_spacing)

        error_message = String.new
        error_message << "#{some_spacing} is not a valid vertical spacing. "
        error_message << 'Must be an Integer in the range (0..).'

        raise AsciiPngfy::Exceptions::InvalidVerticalSpacingError, error_message
      end
    end
  end
end
