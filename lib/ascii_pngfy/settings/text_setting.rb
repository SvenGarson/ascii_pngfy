# frozen_string_literal: true

module AsciiPngfy
  module Settings
    # Reponsibilities
    #   - Keeps track of the text and replacement_text setting
    #   - Validates text and replacement_text
    class TextSetting
      include SetableGetable

      SUPPORTED_ASCII_CODES = [10] + (32..126).to_a.freeze
      SUPPORTED_ASCII_CHARACTERS = SUPPORTED_ASCII_CODES.map(&:chr).freeze

      def initialize
        self.text = String.new
      end

      def get
        text
      end

      def set(desired_text, desired_replacement_text = nil)
        sanitized_text = desired_replacement_text ? String.new : desired_text.dup

        if desired_replacement_text
          desired_replacement_text = validate_text(desired_replacement_text)

          # replace all characters
          # we know the desired text is valid at this point
          desired_text.each_char do |text_character|
            replacement = character_supported?(text_character) ? text_character : desired_replacement_text
            sanitized_text << replacement
          end
        end

        # temporarily use variable to please rubocop
        @desired_replacement_text = desired_replacement_text

        self.text = sanitized_text
      end

      private

      attr_accessor(:text)

      def character_supported?(some_character)
        SUPPORTED_ASCII_CHARACTERS.include?(some_character)
      end

      def string_supported?(some_string)
        some_string.chars.all? do |some_char|
          character_supported?(some_char)
        end
      end

      def validate_text(some_text)
        return some_text if string_supported?(some_text)

        error_message = "#{some_text.inspect} is not a valid replacement string. "\
                        'Must contain only characters with ASCII code 10 or in the range (32..126).'

        raise AsciiPngfy::Exceptions::InvalidReplacementTextError, error_message
      end
    end
  end
end
