# frozen_string_literal: false

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
        self.text = ''

        set('<3 Ascii-Pngfy <3')
      end

      def get
        text
      end

      # the philosophy behind this method is as follows:
      # - The desired_text cannot be empty pre replacement. If it is empty, an error is thrown
      # - When no replacement text is passed, the desired_text is considered as is by
      #   skipping the replacement procedure
      # - When a replacement text is passed though, the replacement text is validated and
      #   all unsupported text characters are replaced with the replacement text
      # - The text is then validated post replacement to make sure it is not empty, the same as
      #   pre replacement
      # - Finally the text is updated with the result
      def set(desired_text, desired_replacement_text = nil)
        desired_text = pre_replacement_text_validation(desired_text, desired_replacement_text)

        if replacement_desired?(desired_replacement_text)
          desired_replacement_text = validate_replacement_text(desired_replacement_text)

          desired_text = replace_unsupported_characters(from: desired_text, with: desired_replacement_text)
        end

        desired_text = post_replacement_text_validation(desired_text)

        self.text = validate_text_contents(desired_text)
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
        # also returns true when the string is empty
        extract_unsupported_characters(some_string).empty?
      end

      def validate_replacement_text(some_text)
        return some_text if string_supported?(some_text)

        error_message = "#{some_text.inspect} is not a valid replacement string. "\
                        'Must contain only characters with ASCII code 10 or in the range (32..126).'

        raise AsciiPngfy::Exceptions::InvalidReplacementTextError, error_message
      end

      def replace_unsupported_characters(from:, with:)
        text_with_replacements = ''

        from.each_char do |text_character|
          replacement_text = character_supported?(text_character) ? text_character : with
          text_with_replacements << replacement_text
        end

        text_with_replacements
      end

      def validate_text_contents(some_text)
        # This method only accounts for non-empty strings that contains unsupported characters.
        # Empty strings are handled separately to separate different types of errors more clearly
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

      def pre_replacement_text_validation(desired_text, desired_replacement_text)
        return desired_text unless desired_text.empty?

        error_message = 'Text cannot be empty because that would result in a PNG with a width or height of zero. '\
                        'Must contain at least one character with ASCII code 10 or in the range (32..126).'

        # hint the user that the desired replacment text is also empty
        if replacement_desired?(desired_replacement_text) && desired_replacement_text.empty?
          error_message << ' Hint: Both the text and the replacement text are empty.'
        end

        raise AsciiPngfy::Exceptions::EmptyTextError, error_message
      end

      def post_replacement_text_validation(desired_text)
        return desired_text unless desired_text.empty?

        error_message = 'Text cannot be empty because that would result in a PNG with a width or height of zero. '\
                        'Must contain at least one character with ASCII code 10 or in the range (32..126). '\
                        'Hint: An empty replacement text causes text with only unsupported characters to end up as '\
                        'empty string.'

        raise AsciiPngfy::Exceptions::EmptyTextError, error_message
      end
    end
  end
end
