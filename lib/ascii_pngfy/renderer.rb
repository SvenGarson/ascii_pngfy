# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - generate result object from the Pngfyer settings
  #   - render supported characters glyph design into result png
  # rubocop: disable Metrics/ClassLength
  class SettingsRenderer
    def initialize(use_glyph_designs: true)
      self.use_glyph_designs = use_glyph_designs
    end

    def render_result(settings_snapshot)
      # settings snapshot updated for every result rendering
      self.settings = settings_snapshot

      png = ChunkyPNG::Image.new(
        determine_png_width,
        determine_png_height,
        color_rgba_to_chunky_png_integer(settings.background_color)
      )

      plot_result(png)

      Result.new(png, determine_render_width, determine_render_height, settings)
    end

    private

    attr_accessor(:settings, :use_glyph_designs)

    def text_lines
      settings.text.split("\n", -1)
    end

    def determine_png_width
      longest_text_line_length = text_lines.max_by(&:length).length
      horizontal_spacing_count = longest_text_line_length - 1

      (longest_text_line_length * 5) + (horizontal_spacing_count * settings.horizontal_spacing)
    end

    def determine_png_height
      text_line_count = text_lines.size
      vertical_spacing_count = text_line_count - 1
      (text_line_count * 9) + (vertical_spacing_count * settings.vertical_spacing)
    end

    def determine_font_multiplier
      settings.font_height / 9
    end

    def determine_render_width
      determine_png_width * determine_font_multiplier
    end

    def determine_render_height
      determine_png_height * determine_font_multiplier
    end

    def text_lines_characters
      text_lines.map(&:chars)
    end

    def determine_font_region(character_column_index, character_row_index)
      font_region_top_left_x = character_column_index * (settings.horizontal_spacing + 5)
      font_region_top_left_y = character_row_index * (settings.vertical_spacing + 9)
      font_region_bottom_right_x = font_region_top_left_x + (5 - 1)
      font_region_bottom_right_y = font_region_top_left_y + (9 - 1)

      AABB.new(
        font_region_top_left_x,
        font_region_top_left_y,
        font_region_bottom_right_x,
        font_region_bottom_right_y
      )
    end

    def each_font_region_with_associated_character(&yielder)
      text_lines_characters.each_with_index do |line_characters, row_index|
        line_characters.each_with_index do |character, column_index|
          font_region = determine_font_region(column_index, row_index)

          yielder.call(font_region, character)
        end
      end
    end

    def each_font_region(&yielder)
      each_font_region_with_associated_character do |font_region, _font_region_character|
        yielder.call(font_region)
      end
    end

    def color_rgba_to_chunky_png_integer(color_rgba)
      ChunkyPNG::Color.rgba(
        color_rgba.red,
        color_rgba.green,
        color_rgba.blue,
        color_rgba.alpha
      )
    end

    def straight_alpha_composite_color_value(over_component, over_alpha, under_component, under_alpha)
      # over refers to the top layer, i.e. the font layer
      ca = over_component
      aa = over_alpha.fdiv(255)

      # under refers to the bottom layer, i.e. the background layer
      cb = under_component
      ab = under_alpha.fdiv(255)

      # return alpha composited color component as integer in range 0..255
      ((ca * aa + cb * ab * (1 - aa)) / (aa + ab * (1 - aa))).to_i
    end

    def straight_alpha_composite_alpha_value(over_alpha, under_alpha)
      aa = over_alpha.fdiv(255)
      ab = under_alpha.fdiv(255)

      # return alpha composited alpha component as integer in range 0..255
      ((aa + ab * (1 - aa)) * 255).to_i
    end

    def straight_alpha_composite_color(over_color, under_color)
      over_color_alpha = over_color.alpha
      under_color_alpha = under_color.alpha

      AsciiPngfy::ColorRGBA.new(
        straight_alpha_composite_color_value(over_color.red, over_color_alpha, under_color.red, under_color_alpha),
        straight_alpha_composite_color_value(over_color.green, over_color_alpha, under_color.green, under_color_alpha),
        straight_alpha_composite_color_value(over_color.blue, over_color_alpha, under_color.blue, under_color_alpha),
        straight_alpha_composite_alpha_value(over_color_alpha, under_color_alpha)
      )
    end

    def determine_possibly_blended_font_and_background_color
      case settings.font_color.alpha
      when 255
        settings.font_color
      else
        straight_alpha_composite_color(settings.font_color, settings.background_color)
      end
    end

    def determine_design_character_pixel_color(design_character)
      if AsciiPngfy::Glyphs.font_layer_design_character?(design_character)
        determine_possibly_blended_font_and_background_color
      elsif AsciiPngfy::Glyphs.background_layer_design_character?(design_character)
        settings.background_color
      end
    end

    def plot_font_regions_with_design(png)
      each_font_region_with_associated_character do |font_region, character|
        # mirror the font design for each font region into the png
        font_region_character_design = AsciiPngfy::Glyphs::DESIGNS[character]

        font_region.each_pixel_with_index do |font_pixel_x, font_pixel_y, font_pixel_index|
          png_pixel_design_character = font_region_character_design[font_pixel_index]

          png_pixel_plot_color = determine_design_character_pixel_color(png_pixel_design_character)
          png_pixel_plot_color_as_integer = color_rgba_to_chunky_png_integer(png_pixel_plot_color)

          png[font_pixel_x, font_pixel_y] = png_pixel_plot_color_as_integer
        end
      end
    end

    def plot_font_regions_without_design(png)
      final_font_color = determine_possibly_blended_font_and_background_color
      final_font_color_as_integer = color_rgba_to_chunky_png_integer(final_font_color)

      each_font_region do |font_region|
        # fill every font region entirely with, the potentially mixed, font and backround color
        font_region.each_pixel do |font_region_x, font_region_y|
          png[font_region_x, font_region_y] = final_font_color_as_integer
        end
      end
    end

    def plot_result(png)
      if use_glyph_designs
        plot_font_regions_with_design(png)
      else
        plot_font_regions_without_design(png)
      end
    end
  end
end
# rubocop: enable Metrics/ClassLength
