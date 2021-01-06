# frozen_string_literal: true

module AsciiPngfy
  # Provides the interface to:
  #  - wrapped rendering setting definition
  #  - texture and usage meta-information generation
  class Renderer
    def initialize
      self.settings = RendererSettings.new
    end

    def set_font_color(red: nil, green: nil, blue: nil, alpha: nil)
      current_font_color = settings.font_color

      set_color_components(red, green, blue, alpha, current_font_color)

      current_font_color.dup
    end

    def set_background_color(red: nil, green: nil, blue: nil, alpha: nil)
      current_background_color = settings.background_color

      set_color_components(red, green, blue, alpha, current_background_color)

      current_background_color.dup
    end

    def set_font_height_closest_to(desired_font_height)
      unless desired_font_height.is_a?(Integer) && desired_font_height >= 9
        error_message = String.new
        error_message << "#{desired_font_height} is not a valid font size. "
        error_message << "Must be an Integer in the range (9..)."
        raise AsciiPngfy::Exceptions::InvalidFontHeightError, error_message
      end

      if (desired_font_height % 9) == 0
        settings.font_height = desired_font_height
      else
        # determine bound - the desired one is not multiple of 9
        multiple_of_nine_remainder = (desired_font_height % 9)
        if [1, 2, 3, 4].include?(multiple_of_nine_remainder)
          # lower bound
          settings.font_height = (desired_font_height / 9) * 9
        elsif [5, 6, 7, 8].include?(multiple_of_nine_remainder)
          # upper bound
          settings.font_height = ((desired_font_height / 9) + 1) * 9
        end
      end

      # return currently set - unless error is raised
      settings.font_height
    end

    private

    attr_accessor(:settings)

    def set_color_components(red, green, blue, alpha, color)
      color.red = red unless red.nil?
      color.green = green unless green.nil?
      color.blue = blue unless blue.nil?
      color.alpha = alpha unless alpha.nil?
    end
  end
end
