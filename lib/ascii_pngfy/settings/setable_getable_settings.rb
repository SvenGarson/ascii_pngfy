# frozen_string_literal: true

module AsciiPngfy
  module Settings
    # Reponsibilities
    #   - Configures ConfigurableSettings instance to support both setters and getters
    #   - Provides a way to create a snapshot of itself where the setters are disabled
    #     so that the settings can only be read
    class SetableGetableSettings < ConfigurableSettings
      def initialize
        super(setable: true, getable: true)
      end

      def getter_only_snapshot
        duplicate = dup
        duplicate.disable_setters
      end
    end
  end
end
