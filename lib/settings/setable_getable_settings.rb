# frozen_string_literal: true

module AsciiPngfy
  module Settings
    # Reponsibilities
    #   - Configures settings instance to support both setting and getting the setting
    class SetableGetableSettings < ConfigurableSettings
      def initialize
        super(setable: true, getable: true)
      end
    end
  end
end
