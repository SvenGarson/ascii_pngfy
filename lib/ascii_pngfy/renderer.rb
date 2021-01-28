# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - generate result object from the Pngfyer settings
  #   - render supported characters glyph design into result png
  class SettingsRenderer
    # Reponsibilities
    #   - represent pixel coordinate pair as integers
    #   - public getters for easy coordinate access
    class Vec2i
      attr_reader(:x, :y)

      def initialize(initial_x = 0, initial_y = 0)
        self.x = initial_x
        self.y = initial_y
      end

      private

      attr_writer(:x, :y)
    end

    # Reponsibilities
    #   - represent an axis aligned bounding box through a minimum and
    #     maximum coordinate coordinate pair
    #   - public getters for easy min and max coordinate pair access
    #   - provide a simple way to iterate all the pixel coordinates in
    #     the respective bounding box through a closure
    class AABB
      attr_reader(:min, :max)

      def initialize(min_x, min_y, max_x, max_y)
        self.min = Vec2i.new(min_x, min_y)
        self.max = Vec2i.new(max_x, max_y)
      end

      def each_pixel
        return nil unless block_given?

        min.y.upto(max.y) do |tile_y|
          min.x.upto(max.x) do |tile_x|
            yield(tile_x, tile_y)
          end
        end
      end

      private

      attr_writer(:min, :max)
    end

    def initialize(settings_snapshot)
      @settings = settings_snapshot
    end

    def render_result
      # prep png image with background color
      png = ChunkyPNG::Image.new(
        determine_png_width,
        determine_png_height,
        color_rgba_to_chunky_png_integer(settings.background_color)
      )

      # plot font region into png - simply plot all and whole font regions
      plot_font_regions_into(png)

      # return the result
      Result.new(png, determine_render_width, determine_render_height, settings)
    end

    private

    attr_accessor(:settings)

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

    def generate_font_regions
      font_regions = []

      text_lines_characters.each_with_index do |line_characters, row_index|
        line_characters.each_with_index do |_character, column_index|
          font_regions << determine_font_region(column_index, row_index)
        end
      end

      font_regions
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

    def determine_final_font_color
      # the font and background colors are only mixed if the font color is transparent
      case settings.font_color.alpha
      when 255
        settings.font_color
      else
        straight_alpha_composite_color(settings.font_color, settings.background_color)
      end
    end

    def plot_font_regions_into(png)
      final_font_color = determine_final_font_color
      final_font_color_as_integer = color_rgba_to_chunky_png_integer(final_font_color)

      generate_font_regions.each do |font_region|
        font_region.each_pixel do |font_region_x, font_region_y|
          png[font_region_x, font_region_y] = final_font_color_as_integer
        end
      end
    end
  end
end
