# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - The reason for this particulare interface with singleton methods
  #     at this point, is to avoid coupling between the settings themselves
  #     and because the architecture is about to change in terms of the
  #     current implementation of the Settings
  #
  #   - Provide a single point of reference for all computations that
  #     contribute to the renderer result of the Pngfy process
  #
  #   - Computations based on setting implementation values such as
  #     color; font height; spacing and text
  #
  #   - Generalized enough so that any settings related context can
  #     access this data if needed
  # rubocop: disable Metrics/ModuleLength
  module RenderingRules
    def self.text_lines(text)
      text.split("\n", -1)
    end

    def self.longest_text_line(text)
      text_lines(text).max_by(&:length)
    end

    def self.png_width(settings, override_text = nil)
      use_text = override_text || settings.text

      longest_text_line_length = longest_text_line(use_text).length
      horizontal_spacing_count = longest_text_line_length - 1

      (longest_text_line_length * GLYPH_DESIGN_WIDTH) + (horizontal_spacing_count * settings.horizontal_spacing)
    end

    def self.png_height(settings, override_text = nil)
      use_text = override_text || settings.text

      text_line_count = text_lines(use_text).size
      vertical_spacing_count = text_line_count - 1

      (text_line_count * GLYPH_DESIGN_HEIGHT) + (vertical_spacing_count * settings.vertical_spacing)
    end

    def self.font_multiplier(settings)
      settings.font_height / GLYPH_DESIGN_HEIGHT
    end

    def self.render_width(settings)
      png_width(settings) * font_multiplier(settings)
    end

    def self.render_height(settings)
      png_height(settings) * font_multiplier(settings)
    end

    def self.text_lines_characters(settings)
      text_lines(settings.text).map(&:chars)
    end

    def self.font_region(settings, character_column_index, character_row_index)
      font_region_top_left_x = character_column_index * (settings.horizontal_spacing + GLYPH_DESIGN_WIDTH)
      font_region_top_left_y = character_row_index * (settings.vertical_spacing + GLYPH_DESIGN_HEIGHT)
      font_region_bottom_right_x = font_region_top_left_x + (GLYPH_DESIGN_WIDTH - 1)
      font_region_bottom_right_y = font_region_top_left_y + (GLYPH_DESIGN_HEIGHT - 1)

      AABB.new(
        font_region_top_left_x,
        font_region_top_left_y,
        font_region_bottom_right_x,
        font_region_bottom_right_y
      )
    end

    def self.each_font_region_with_associated_character(settings, &yielder)
      text_lines_characters(settings).each_with_index do |line_characters, row_index|
        line_characters.each_with_index do |character, column_index|
          font_region = font_region(settings, column_index, row_index)

          yielder.call(font_region, character)
        end
      end
    end

    def self.each_font_region(settings, &yielder)
      each_font_region_with_associated_character(settings) do |font_region, _font_region_character|
        yielder.call(font_region)
      end
    end

    def self.color_rgba_to_chunky_png_integer(color_rgba)
      ChunkyPNG::Color.rgba(
        color_rgba.red,
        color_rgba.green,
        color_rgba.blue,
        color_rgba.alpha
      )
    end

    def self.straight_alpha_composite_color_value(over_component, over_alpha, under_component, under_alpha)
      # over refers to the top layer, i.e. the font layer
      ca = over_component
      aa = over_alpha.fdiv(255)

      # under refers to the bottom layer, i.e. the background layer
      cb = under_component
      ab = under_alpha.fdiv(255)

      # return alpha composited color component as integer in range 0..255
      # avoid divisions by zero
      numerator = (ca * aa + cb * ab * (1 - aa))
      denumerator = (aa + ab * (1 - aa))

      return 0 if denumerator.zero? || numerator.zero?

      (numerator / denumerator).to_i
    end

    def self.straight_alpha_composite_alpha_value(over_alpha, under_alpha)
      aa = over_alpha.fdiv(255)
      ab = under_alpha.fdiv(255)

      # return alpha composited alpha component as integer in range 0..255
      ((aa + ab * (1 - aa)) * 255).to_i
    end

    def self.straight_alpha_composite_color(over_color, under_color)
      over_color_alpha = over_color.alpha
      under_color_alpha = under_color.alpha

      AsciiPngfy::ColorRGBA.new(
        straight_alpha_composite_color_value(over_color.red, over_color_alpha, under_color.red, under_color_alpha),
        straight_alpha_composite_color_value(over_color.green, over_color_alpha, under_color.green, under_color_alpha),
        straight_alpha_composite_color_value(over_color.blue, over_color_alpha, under_color.blue, under_color_alpha),
        straight_alpha_composite_alpha_value(over_color_alpha, under_color_alpha)
      )
    end

    def self.possibly_blended_font_and_background_color(settings)
      case settings.font_color.alpha
      when 255
        settings.font_color
      else
        straight_alpha_composite_color(settings.font_color, settings.background_color)
      end
    end

    def self.design_character_pixel_color(settings, design_character)
      if AsciiPngfy::Glyphs.font_layer_design_character?(design_character)
        possibly_blended_font_and_background_color(settings)
      elsif AsciiPngfy::Glyphs.background_layer_design_character?(design_character)
        settings.background_color
      end
    end

    def self.plot_font_regions_with_design(settings, png)
      each_font_region_with_associated_character(settings) do |font_region, character|
        # the only ASCII character that has an empty glyph desgn is the space
        # as long as the space is empty, nothing needs to be rendered
        next if character == ' '

        # mirror the font design for each font region into the png
        font_region_character_design = AsciiPngfy::Glyphs::DESIGNS[character]

        font_region.each_pixel_with_index do |font_pixel_x, font_pixel_y, font_pixel_index|
          png_pixel_design_character = font_region_character_design[font_pixel_index]

          png_pixel_plot_color = design_character_pixel_color(settings, png_pixel_design_character)
          png_pixel_plot_color_as_integer = color_rgba_to_chunky_png_integer(png_pixel_plot_color)

          png[font_pixel_x, font_pixel_y] = png_pixel_plot_color_as_integer
        end
      end
    end

    def self.plot_font_regions_without_design(settings, png)
      final_font_color = possibly_blended_font_and_background_color(settings)
      final_font_color_as_integer = color_rgba_to_chunky_png_integer(final_font_color)

      each_font_region(settings) do |font_region|
        # fill every font region entirely with, the potentially mixed, font and backround color
        font_region.each_pixel do |font_region_x, font_region_y|
          png[font_region_x, font_region_y] = final_font_color_as_integer
        end
      end
    end

    def self.plot_settings(settings, use_glyph_designs, png)
      if use_glyph_designs
        plot_font_regions_with_design(settings, png)
      else
        plot_font_regions_without_design(settings, png)
      end
    end
  end
end
# rubocop: enable Metrics/ModuleLength
