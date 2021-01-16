# frozen_string_literal: true

module AsciiPngfy
  module Settings
    # Reponsibilities
    #   - Keeps track of the text and replacement_text setting
    #   - Validates text and replacement_text
    #   - Replaces unsupported text characters with replacement text
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
        if replacement_desired?(desired_replacement_text)
          desired_replacement_text = validate_text(desired_replacement_text)

          desired_text_with_replacements = desired_text.chars.map do |text_character|
            text_character_replacement(text_character, desired_replacement_text)
          end

          desired_text = desired_text_with_replacements.join
        end

        # temporarily use variable to please rubocop
        @desired_replacement_text = desired_replacement_text

        self.text = desired_text
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

      def replacement_desired?(replacement_text)
        !!replacement_text
      end

      def text_character_replacement(text_character, desired_replacement_text)
        character_supported?(text_character) ? text_character : desired_replacement_text
      end
    end
  end
end
