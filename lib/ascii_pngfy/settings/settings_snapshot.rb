# frozen_string_literal: true

module AsciiPngfy
  module Settings
    # Reponsibilities
    #   - Keeps track of the setting values at the point of creation
    #     of this snapshot
    #   - Dynamic getter for each setting name which simply returns
    #     the value of the respective setting
    class SettingsSnapshot
      def initialize(setting_names_and_values)
        self.setting_names_and_values = setting_names_and_values
      end

      def respond_to_missing?(setting_name, _)
        setting_exists?(setting_name) || super
      end

      def method_missing(setting_name, *_arguments)
        super unless respond_to?(setting_name)

        # return that settings value
        setting_names_and_values[setting_name]
      end

      private

      def setting_exists?(setting_name)
        setting_names_and_values.key?(setting_name)
      end

      attr_accessor(:setting_names_and_values)
    end
  end
end
