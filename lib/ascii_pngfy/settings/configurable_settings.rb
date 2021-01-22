# frozen_string_literal: true

module AsciiPngfy
  module Settings
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

      def dup
        duplicate = super

        # the supported_operations hash can be dupped at the hash because keys are symbols and the values
        # are booleans, i.e. both the keys and the values always point to the same symbol/boolean in memory
        # for a given value
        duplicate.supported_operations = duplicate.supported_operations.dup

        # the supported_settings hash must be dupped at the hash level as well as each value for every k/v pair
        # because the keys are symbols, so always point to the same value in memory and the values are custom class
        # instances and may need specific duplication logic at that implementation level to avoid state sharing
        # between duplicated objects
        duplicate.settings = duplicate.settings.dup.transform_values(&:dup)

        duplicate
      end

      protected

      def disable_setters
        supported_operations[SET] = false
        self
      end

      attr_accessor(:supported_operations, :settings)

      private

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
  end
end
