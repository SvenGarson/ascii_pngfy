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

      # the philosophy behind this method is:
      #  - When no replacement text is passed, the text is judged as is
      #  - Otherwise the replacement text is validated and all unsupported
      #    text characters are replaced with the replacement text
      #  - the text is judged afer the optional replacement, wether or
      #    not replacement has taken place or not
      def set(desired_text, desired_replacement_text = nil)
        if replacement_desired?(desired_replacement_text)
          desired_replacement_text = validate_replacement_text(desired_replacement_text)

          desired_text_with_replacements = desired_text.chars.map do |text_character|
            text_character_replacement(text_character, desired_replacement_text)
          end.join

          desired_text = desired_text_with_replacements
        end

        # judge text wether replacement has been performed or not
        desired_text = validate_text(desired_text)

        # logic got here - text is string with only supported characters
        self.text = desired_text
      end

      private

      attr_accessor(:text)

      def character_supported?(some_character)
        SUPPORTED_ASCII_CHARACTERS.include?(some_character)
      end

      def extract_unsupported_characters(some_string)
        unsupported_characters = []

        some_string.each_char do |some_char|
          unsupported_characters << some_char unless character_supported?(some_char)
        end

        unsupported_characters
      end

      def string_supported?(some_string)
        extract_unsupported_characters(some_string).empty?
      end

      def validate_replacement_text(some_text)
        return some_text if string_supported?(some_text)

        error_message = "#{some_text.inspect} is not a valid replacement string. "\
                        'Must contain only characters with ASCII code 10 or in the range (32..126).'

        raise AsciiPngfy::Exceptions::InvalidReplacementTextError, error_message
      end

      def validate_text(some_text)
        return some_text if string_supported?(some_text)

        un_supported_characters = extract_unsupported_characters(some_text)
        un_supported_inspected_characters = un_supported_characters.map(&:inspect)
        un_supported_characters_list = "#{un_supported_inspected_characters[0..-2].join(', ')} and "\
                                         "#{un_supported_inspected_characters.last}"

        error_message = "#{un_supported_characters_list} are all invalid text characters. "\
                        'Must contain only characters with ASCII code 10 or in the range (32..126).'

        raise AsciiPngfy::Exceptions::InvalidCharacterError, error_message
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
