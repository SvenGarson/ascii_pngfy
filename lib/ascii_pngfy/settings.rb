# frozen_string_literal: true

module AsciiPngfy
  # Namespace that that contains Setting(s) related functionality
  module Settings

    class ColorSetting
      def initialize(red, green, blue, alpha)
        @color = ColorRGBA.new(red, green, blue, alpha)
      end

      def get
        @color.dup
      end

      def set(red: nil, green: nil, blue: nil, alpha: nil)
        @color.red = red unless red.nil?
        @color.green = green unless green.nil?
        @color.blue = blue unless blue.nil?
        @color.alpha = alpha unless alpha.nil?

        @color.dup
      end
    end

    # Reponsibilities
    #   - Pipe setter and getter calls to a specific Setting implementation
    #   - Defines wether the settings can be set and/or retreived(get) externally
    #   - Register settings based on settings defined externally througj a builder
    #   > Raise errors that inform about wether:
    #       - setting exists
    #       - setting has been fully implemented
    #       - get and set operations are supported operations on the defined settings
    #       - the added settings support the required set/get interface
    class ConfigurableSettings
      GET = :get
      SET = :set

      def initialize(setable: false, getable: true)
        self.supported_operations = {
          SET => setable,
          GET => getable
        }

        # use builder somehow
        self.settings = {
          font_color: ColorSetting.new(255, 255, 255, 255)
        }
      end

      def method_missing(method_name, *arguments)
        setting_operation = setter?(method_name) ? SET : GET

        unless operation_supported?(setting_operation)
          raise StandardError, "#{setting_operation} not supported!"
        end

        setting_name = extract_setting_name_as_symbol(method_name)
        unless setting_exists?(setting_name)
          raise StandardError, "#{setting_name} is not registered as setting!"
        end

        # use the action on the approproate setting
        setting(setting_name).public_send(setting_operation, *arguments)
      end

      private

      def setting(setting_name)
        settings[setting_name]
      end

      def setting_exists?(setting_name)
        settings.has_key?(setting_name)
      end

      def operation_supported?(operation)
        supported_operations[operation]
      end

      def setter?(method_name)
        method_name.start_with?('set_')
      end

      def getter?(method_name)
        !setter?(metWhod_name)
      end

      def extract_setting_name_as_symbol(method_name)
        if setter?(method_name)
          method_name[4..-1]
        else
          method_name
        end.to_sym
      end

      attr_accessor(:supported_operations, :settings)
    end

    class SetableGetableSettings < ConfigurableSettings
      def initialize
        super(setable: true, getable: true)
      end
    end
  end
end