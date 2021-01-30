# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - Provide the complete interface of this gem
  #   - References settings and pipe user setting calls
  #     to the appropriate setting if the are defined
  #   - Provide the settings to be used for this gem
  class Pngfyer
    def initialize(use_glyph_designs: true)
      self.settings_renderer = SettingsRenderer.new(use_glyph_designs: use_glyph_designs)
      self.settings = Settings::SetableGetableSettings.new
    end

    def respond_to_missing?(method_name, *)
      settings_call?(method_name) || super
    end

    def method_missing(method_name, *arguments)
      # forward only set_* calls to the settings so that the
      # respective setting can enforce it's interface
      if settings_call?(method_name)
        setting_call = method_name
        settings.public_send(setting_call, *arguments)
      else
        super
      end
    end

    def pngfy
      settings_snapshot = settings.getter_only_snapshot
      settings_renderer.render_result(settings_snapshot)
    end

    private

    attr_accessor(:settings, :settings_renderer)

    def settings_call?(method_name)
      method_name.start_with?('set_')
    end
  end
end
