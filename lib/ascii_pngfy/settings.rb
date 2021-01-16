# frozen_string_literal: true

module AsciiPngfy
  # Namespace that that contains Setting(s) related functionality
  module Settings
    # Reponsibilities
    #   - Keeps track of the color setting(s)
    #   - Validated through ColorRGBA implicitly
    class ColorSetting
      def initialize(initial_red, initial_green, initial_blue, initial_alpha)
        self.color = ColorRGBA.new(initial_red, initial_green, initial_blue, initial_alpha)
      end

      def get
        color.dup
      end

      def set(red: nil, green: nil, blue: nil, alpha: nil)
        color.red = red unless red.nil?
        color.green = green unless green.nil?
        color.blue = blue unless blue.nil?
        color.alpha = alpha unless alpha.nil?

        color.dup
      end

      private

      attr_accessor(:color)
    end

    # Reponsibilities
    #   - Keeps track of the the font_height setting
    #   - Validates font_height
    class FontHeightSetting
      def initialize(initial_font_height)
        self.font_height = initial_font_height
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

    # Reponsibilities
    #   - Keeps track of the the vertical_spacing setting
    #   - Validates vertical_spacing
    class VerticalSpacingSetting
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

    # Reponsibilities
    #   - Keeps track of the text and replacement_text setting
    #   - Validates text and replacement_text
    class TextSetting
      SUPPORTED_ASCII_CODES = [10] + (32..126).to_a.freeze
      SUPPORTED_ASCII_CHARACTERS = SUPPORTED_ASCII_CODES.map(&:chr).freeze

      def initialize
        self.text = String.new
      end

      def get
        text
      end

      def set(desired_text, desired_replacement_text = nil)
        # consider replacement only when non-nil
        desired_replacement_text = validate_text(desired_replacement_text) if desired_replacement_text

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
    end

    # Reponsibilities
    #   - Pipe setter and getter calls to a specific Setting implementation
    #   - Defines wether the settings can be set and/or retreived(get) externally
    #   - Register supported settings and what name to associate each setting to
    class ConfigurableSettings
      GET = :get
      SET = :set

      def initialize(setable: false, getable: true)
        initialize_supported_operations(setable, getable)
        initialize_supported_settings
      end

      def respond_to_missing?(method_name, *)
        setting_operation = determine_operation(method_name)
        operation_supported = operation_supported?(setting_operation)

        setting_name = determine_setting_name_as_symbol(method_name)
        setting_exists = setting_exists?(setting_name)

        (operation_supported && setting_exists) || super
      end

      def method_missing(method_name, *arguments)
        super unless respond_to?(method_name)

        # respond_to? determines wether the operation is supported and
        # the setting exists
        setting_operation = determine_operation(method_name)
        setting_name = determine_setting_name_as_symbol(method_name)

        setting(setting_name).public_send(setting_operation, *arguments)
      end

      private

      attr_accessor(:supported_operations, :settings)

      def initialize_supported_operations(setable, getable)
        self.supported_operations = {
          SET => setable,
          GET => getable
        }
      end

      def initialize_supported_settings
        self.settings = {
          font_color: ColorSetting.new(255, 255, 255, 255),
          background_color: ColorSetting.new(0, 0, 0, 255),
          font_height: FontHeightSetting.new(9),
          horizontal_spacing: HorizontalSpacingSetting.new(1),
          vertical_spacing: VerticalSpacingSetting.new(1),
          text: TextSetting.new
        }
      end

      def setting(setting_name)
        settings[setting_name]
      end

      def setting_exists?(setting_name)
        settings.key?(setting_name)
      end

      def operation_supported?(operation)
        supported_operations[operation]
      end

      def setter?(method_name)
        method_name.start_with?('set_')
      end

      def determine_operation(method_name)
        setter?(method_name) ? SET : GET
      end

      def determine_setting_name_as_symbol(method_name)
        if setter?(method_name)
          method_name[4..]
        else
          method_name
        end.to_sym
      end
    end

    # Reponsibilities
    #   - Configures settings instance to support both setting and getting the setting
    class SetableGetableSettings < ConfigurableSettings
      def initialize
        super(setable: true, getable: true)
      end
    end
  end
end
