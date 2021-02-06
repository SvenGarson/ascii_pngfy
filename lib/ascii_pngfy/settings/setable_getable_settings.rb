# frozen_string_literal: true

module AsciiPngfy
  module Settings
    # Reponsibilities
    #   - Pipes setter and getter calls to a specific Setting instance
    #   - Associates supported settings with the respective Setting name
    #   - Generates a SettingsSnapshot object for the purpose of describing
    #     a specific set of settings at the time of the snapshot generation
    class SetableGetableSettings
      GET = :get
      SET = :set

      def initialize
        initialize_supported_settings
      end

      def respond_to_missing?(method_name, _)
        setting_name = determine_setting_name_as_symbol(method_name)

        setting_exists?(setting_name) || super
      end

      def method_missing(method_name, *arguments)
        super unless respond_to?(method_name)

        setting_operation = determine_operation(method_name)
        setting_name = determine_setting_name_as_symbol(method_name)

        # call the settings #set or #get method depending on the operation
        setting(setting_name).public_send(setting_operation, *arguments)
      end

      def snapshot
        snapshot_settings = settings.dup
        snapshot_settings.transform_values!(&:get)

        SettingsSnapshot.new(snapshot_settings)
      end

      private

      attr_accessor(:settings)

      def add(setting_name, setting_instance)
        self.settings ||= {}

        settings[setting_name] = setting_instance
      end

      def initialize_supported_settings
        add(:font_color, ColorSetting.new(255, 255, 255, 255))
        add(:background_color, ColorSetting.new(0, 0, 0, 255))
        add(:font_height, FontHeightSetting.new(9))
        add(:horizontal_spacing, HorizontalSpacingSetting.new(1))
        add(:vertical_spacing, VerticalSpacingSetting.new(1))
        add(:text, TextSetting.new(self))
      end

      def setting(setting_name)
        settings[setting_name]
      end

      def setting_exists?(setting_name)
        settings.key?(setting_name)
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
