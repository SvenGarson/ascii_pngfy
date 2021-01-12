# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - Pipe setter and getter calls to a specific Setting implementation
  #   - Defines wether the settings can be set and/or retreived(get) externally
  #   - Register settings based on settings defined externally througj a builder
  #   > Raise errors that inform about wether:
  #       - setting exists
  #       - setting has been fully implemented
  #       - get and set operations are supported operations on the defined settings
  #       - the added settings support the required set/get interface
  class Settings
    attr_accessor(:font_color)

    def initialize
      @font_color = ColorRGBA.new(255, 255, 255, 255)
    end

    def set_font_color(red: nil, green: nil, blue: nil, alpha: nil)
      @font_color.red = red unless red.nil?
      @font_color.green = green unless green.nil?
      @font_color.blue = blue unless blue.nil?
      @font_color.alpha = alpha unless alpha.nil?

      @font_color.dup
    end
  end
end
