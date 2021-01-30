# frozen_string_literal: false

module AsciiPngfy
  module Settings
    # Reponsibilities
    #   - Keeps track of the text and replacement_text setting
    #   - Validates text and replacement_text, partially by referring to other
    #     other modules such as for instance the Renderer for render related
    #     computations validate from a single point of implementation
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
        text.dup
      end

      # the philosophy behind this method is as follows:
      # - The desired_text cannot be empty pre replacement. If it is empty, an error is thrown
      # - When no replacement text is passed, the desired_text is considered as is by
      #   skipping the replacement procedure
      # - When a replacement text is passed though, the replacement text is validated and
      #   all unsupported text characters are replaced with the replacement text
      # - The text is then validated post replacement to make sure it is not empty, the same as
      #   pre replacement
      # - At this point the text is validated to only contain supported ASCII characters
      #   and has its dimensions checked in terms of the needed png texture size needed
      #   to fit the resulting text along with the character spacing previously set.
      # - Finally the text is updated
      def set(desired_text, desired_replacement_text = nil)
        pre_replacement_text_validation(desired_text, desired_replacement_text)

        if replacement_desired?(desired_replacement_text)
          desired_replacement_text = validate_replacement_text(desired_replacement_text)

          desired_text = replace_unsupported_characters(from: desired_text, with: desired_replacement_text)
        end

        post_replacement_text_validation(desired_text)
        validate_text_contents(desired_text)
        validate_text_image_dimensions(desired_text)

        # set the fully validated and possibly sanitized text
        self.text = desired_text.dup

        desired_text
      end

      def initialize_copy(original_text_setting)
        self.text = original_text_setting.text.dup
      end

      protected

      attr_accessor(:text)

      private

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

      def replacement_desired?(replacement_text)
        !!replacement_text
      end

      def pre_replacement_text_validation(desired_text, desired_replacement_text)
        return desired_text unless desired_text.empty?

        error_message = 'Text cannot be empty because that would result in a PNG with a width or height of zero. '\
                        'Must contain at least one character with ASCII code 10 or in the range (32..126).'

        # hint the user that the desired replacement text is also empty
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

      def validate_text_image_width(desired_text, image_width)
        return desired_text unless image_width > AsciiPngfy::MAX_RESULT_PNG_IMAGE_WIDTH

        # old, assuming implementation
        longest_text_line = desired_text.split("\n", -1).max_by(&:size)

        # new impl that determines the desired interface to the actual implementation
        # longest_text_line = AsciiPngfy::Renderer.longest_text_line(desired_text)

        capped_text = cap_string(longest_text_line, '..', 60)

        error_message = "The text line #{capped_text.inspect} is too long to be represented in a "\
                        "#{AsciiPngfy::MAX_RESULT_PNG_IMAGE_WIDTH} pixel wide png. Hint: Use shorter "\
                        'text lines and/or reduce the horizontal character spacing.'

        raise AsciiPngfy::Exceptions::TextLineTooLongError, error_message
      end

      def validate_text_image_height(desired_text, image_height)
        return desired_text unless image_height > AsciiPngfy::MAX_RESULT_PNG_IMAGE_HEIGHT

        capped_text = cap_string(desired_text, '..', 60)

        error_message = "The text #{capped_text.inspect} contains too many lines to be represented in a "\
                        "#{MAX_RESULT_PNG_IMAGE_HEIGHT} pixel high png. Hint: Use less text lines and/or "\
                        'reduce the vertical character spacing.'

        raise AsciiPngfy::Exceptions::TooManyTextLinesError, error_message
      end

      def validate_text_image_dimensions(desired_text)
        image_width, image_height = determine_text_image_dimensions(desired_text)

        validate_text_image_width(desired_text, image_width)
        validate_text_image_height(desired_text, image_height)
      end

      def determine_text_image_dimensions(desired_text)
        # the same logic will probably be needed in the renderer to plot the image
        # for now keep this here but it is not the responsibility of the text settings
        # and also this assumed the character spacing and does not actually use the
        # settings set before
        text_lines = desired_text.split("\n", -1)
        longest_line_length = text_lines.max_by(&:length).size
        lines_total = text_lines.length

        horizontal_spacing_count = longest_line_length - 1
        vertical_spacing_count = lines_total - 1
        texture_width = (longest_line_length * 5) + (horizontal_spacing_count * 0)
        texture_height = (lines_total * 9) + (vertical_spacing_count * 0)

        [texture_width, texture_height]
      end

      def cap_string(some_string, desired_separator, desired_cap_length)
        if some_string.length <= desired_cap_length
          some_string
        else
          half_cap_length = (desired_cap_length - desired_separator.length) / 2

          string_beginning_portion = some_string[0, half_cap_length]
          string_end_portion = some_string[-half_cap_length..]

          "#{string_beginning_portion}#{desired_separator}#{string_end_portion}"
        end
      end
    end
  end
end
