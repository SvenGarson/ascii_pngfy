# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - Helper used to represent integer pixel coordinate pair
  #   - Public getters for each coordinate
  class Vec2i
    attr_reader(:x, :y)

    def initialize(initial_x = 0, initial_y = 0)
      self.x = initial_x
      self.y = initial_y
    end

    def to_s
      "[#{x}, #{y}]"
    end

    private

    attr_writer(:x, :y)
  end
end
