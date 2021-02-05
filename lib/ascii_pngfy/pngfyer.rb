# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - Provide the complete interface of this gem dynamically
  #     in order to force the interface of the Settings onto the caller
  #   - Orchestrates the Settings and the SettingsRenderer
  class Pngfyer
    def initialize(use_glyph_designs: true)
      self.settings_renderer = SettingsRenderer.new(use_glyph_designs: use_glyph_designs)
      self.settings = Settings::SetableGetableSettings.new
    end

    def respond_to_missing?(method_name, _)
      setter?(method_name) || super
    end

    def method_missing(method_name, *arguments)
      # forward only set_* calls to the settings so that the respective setting
      # can enforce it's interface and any unsupported setting setters results
      # in an undefined method error
      if setter?(method_name)
        setting_call = method_name
        settings.public_send(setting_call, *arguments)
      else
        super
      end
    end

    def pngfy
      settings_snapshot = settings.snapshot
      settings_renderer.render_result(settings_snapshot)
    end

    private

    attr_accessor(:settings, :settings_renderer)

    def setter?(method_name)
      method_name.start_with?('set_')
    end
  end
end
