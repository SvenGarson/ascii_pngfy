# frozen_string_literal: true

module AsciiPngfy
  module Settings
    # Reponsibilities
    #   - Keeps track of the the font_height setting
    #   - Validates font_height
    class FontHeightSetting
      include SetableGetable

      def initialize(initial_font_height)
        self.font_height = 9

        set(initial_font_height)
      end

      def get
        font_height
      end

      def set(desired_font_height)
        validated_font_height = validate_font_height(desired_font_height)

        new_font_height =
          if multiple_of_9?(validated_font_height)
            validated_font_height
          else
            lower_bound_distance = (validated_font_height % 9)
            determine_bound_font_height(validated_font_height, lower_bound_distance)
          end

        self.font_height = new_font_height
      end

      private

      attr_accessor(:font_height)

      def font_height_valid?(some_font_height)
        some_font_height.is_a?(Integer) && (some_font_height >= 9)
      end

      def validate_font_height(some_font_height)
        return some_font_height if font_height_valid?(some_font_height)

        error_message = String.new
        error_message << "#{some_font_height} is not a valid font size. "
        error_message << 'Must be an Integer in the range (9..).'

        raise AsciiPngfy::Exceptions::InvalidFontHeightError, error_message
      end

      def multiple_of_9?(number)
        (number % 9).zero?
      end

      def lower_bound_distance?(distance)
        [1, 2, 3, 4].include?(distance)
      end

      def higher_bound_distance?(distance)
        [5, 6, 7, 8].include?(distance)
      end

      def determine_bound_font_height(validated_font_height, lower_bound_distance)
        if lower_bound_distance?(lower_bound_distance)
          (validated_font_height / 9) * 9
        elsif higher_bound_distance?(lower_bound_distance)
          ((validated_font_height / 9) + 1) * 9
        end
      end
    end
  end
end
