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

    # rubocop:disable Naming/AccessorMethodName
    def set_font_height_closest_to(desired_font_height)
      validated_font_height = validate_font_height(desired_font_height)

      new_font_height =
        if multiple_of_9?(validated_font_height)
          validated_font_height
        else
          lower_bound_distance = (validated_font_height % 9)
          determine_bound_font_height(validated_font_height, lower_bound_distance)
        end

      settings.font_height = new_font_height
    end
    # rubocop:enable Naming/AccessorMethodName

    # rubocop:disable Naming/AccessorMethodName
    def set_horizontal_spacing(desired_horizontal_spacing)
      settings.horizontal_spacing = validate_horizontal_spacing(desired_horizontal_spacing)
    end

    def set_vertical_spacing(desired_vertical_spacing)
      settings.vertical_spacing = validate_vertical_spacing(desired_vertical_spacing)
    end
    # rubocop:enable Naming/AccessorMethodName

    private

    attr_accessor(:settings)

    def set_color_components(red, green, blue, alpha, color)
      color.red = red unless red.nil?
      color.green = green unless green.nil?
      color.blue = blue unless blue.nil?
      color.alpha = alpha unless alpha.nil?
    end

    def font_height_valid?(font_height)
      font_height.is_a?(Integer) && (font_height >= 9)
    end

    def validate_font_height(font_height)
      return font_height if font_height_valid?(font_height)

      error_message = String.new
      error_message << "#{font_height} is not a valid font size. "
      error_message << 'Must be an Integer in the range (9..).'

      raise AsciiPngfy::Exceptions::InvalidFontHeightError, error_message
    end

    def multiple_of_9?(number)
      (number % 9).zero?
    end

    def lower_bound_distance?(distance)
      [1, 2, 3, 4].include?(distance)
    end

    def higher_bound_distance?(distance)
      [5, 6, 7, 8].include?(distance)
    end

    def determine_bound_font_height(validated_font_height, lower_bound_distance)
      if lower_bound_distance?(lower_bound_distance)
        (validated_font_height / 9) * 9
      elsif higher_bound_distance?(lower_bound_distance)
        ((validated_font_height / 9) + 1) * 9
      end
    end

    def spacing_valid?(spacing)
      spacing.is_a?(Integer) && (0..).cover?(spacing)
    end

    def validate_horizontal_spacing(spacing)
      return spacing if spacing_valid?(spacing)

      error_message = String.new
      error_message << "#{spacing} is not a valid horizontal spacing. "
      error_message << 'Must be an Integer in the range (0..).'

      raise AsciiPngfy::Exceptions::InvalidHorizontalSpacingError, error_message
    end

    def validate_vertical_spacing(spacing)
      return spacing if spacing_valid?(spacing)

      error_message = String.new
      error_message << "#{spacing} is not a valid vertical spacing. "
      error_message << 'Must be an Integer in the range (0..).'

      raise AsciiPngfy::Exceptions::InvalidVerticalSpacingError, error_message
    end
  end
end
