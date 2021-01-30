# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - represent an axis aligned bounding box through a minimum and
  #     maximum coordinate pair
  #   - public getters for easy min and max coordinate pair access
  #   - provide a simple way to iterate all the pixel coordinates in
  #     the respective bounding with and without pixel index
  #
  #     this pixel index follows the conventions used for the glyph
  #     design string where the index increases based on the iterated
  #     pixel from:
  #       - topmost row to bottommost row
  #       - leftmost pixel to rightmost pixel for each of these rows
  class AABB
    attr_reader(:min, :max)

    def initialize(min_x, min_y, max_x, max_y)
      self.min = Vec2i.new(min_x, min_y)
      self.max = Vec2i.new(max_x, max_y)
    end

    def each_pixel(&yielder)
      min.y.upto(max.y) do |pixel_y|
        min.x.upto(max.x) do |pixel_x|
          yielder.call(pixel_x, pixel_y)
        end
      end
    end

    def each_pixel_with_index(&yielder)
      pixel_index = 0
      each_pixel do |pixel_x, pixel_y|
        yielder.call(pixel_x, pixel_y, pixel_index)

        pixel_index += 1
      end
    end

    def to_s
      "min#{min} max#{max}"
    end

    private

    attr_writer(:min, :max)
  end
end
