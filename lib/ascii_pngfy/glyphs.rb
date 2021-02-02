# frozen_string_literal: true

module AsciiPngfy
  # Reponsibilities
  #   - provide pixel plotting designs for all supported non-control
  #     ASCII characters
  #   - decides which design character, '.' or '#', represents the
  #     font layer and which represents the background layer
  # rubocop: disable Metrics/ModuleLength
  module Glyphs
    DESIGNS = {
      ' ' => '.............................................',
      '!' => '..#....#....#....#....#.........#............',
      '"' => '.#.#..#.#..#.#...............................',
      '#' => '......#.#.#####.#.#..#.#.#####.#.#...........',
      '$' => '..#...#####.#...###...#.#####...#............',
      '%' => '#...##...#...#...#...#...#...##...#..........',
      '&' => '.##..#..#.#..#..#####..#.#..#..##.#..........',
      "'" => '..#....#....#................................',
      '(' => '...#...#....#...#.....#....#.....#...........',
      ')' => '.#.....#....#.....#...#....#...#.............',
      '*' => '.......#..#.#.#.###.#.#.#..#.................',
      '+' => '.......#....#..#####..#....#.................',
      ',' => '...........................#....#...#........',
      '-' => '...............#####.........................',
      '.' => '...........................#....#............',
      '/' => '....#....#...#...#...#...#....#..............',
      '0' => '.###.#...##..###.#.###..##...#.###...........',
      '1' => '..#...##....#....#....#....#..#####..........',
      '2' => '.###.#...#....#...#...#...#...#####..........',
      '3' => '.###.#...#....#.###.....##...#.###...........',
      '4' => '.#..#.#..##...######....#....#....#..........',
      '5' => '######....#....####.....##...#.###...........',
      '6' => '.###.#....#....####.#...##...#.###...........',
      '7' => '#####....#....#...#...#....#....#............',
      '8' => '.###.#...##...#.###.#...##...#.###...........',
      '9' => '.###.#...##...#.####....##...#.###...........',
      ':' => '.......#....#..............#....#............',
      ';' => '.......#....#..............#....#...#........',
      '<' => '........##.##..#.....##.....##...............',
      '=' => '..........#####.....#####....................',
      '>' => '.....##.....##.....#..##.##..................',
      '?' => '.###.#...#....#...#...#.........#............',
      '@' => '#####.....#####.....#####.....#####.....#####',
      'A' => '#####.....#####.....#####.....#####.....#####',
      'B' => '#####.....#####.....#####.....#####.....#####',
      'C' => '#####.....#####.....#####.....#####.....#####',
      'D' => '#####.....#####.....#####.....#####.....#####',
      'E' => '#####.....#####.....#####.....#####.....#####',
      'F' => '#####.....#####.....#####.....#####.....#####',
      'G' => '#####.....#####.....#####.....#####.....#####',
      'H' => '#####.....#####.....#####.....#####.....#####',
      'I' => '#####.....#####.....#####.....#####.....#####',
      'J' => '#####.....#####.....#####.....#####.....#####',
      'K' => '#####.....#####.....#####.....#####.....#####',
      'L' => '#####.....#####.....#####.....#####.....#####',
      'M' => '#####.....#####.....#####.....#####.....#####',
      'N' => '#####.....#####.....#####.....#####.....#####',
      'O' => '#####.....#####.....#####.....#####.....#####',
      'P' => '#####.....#####.....#####.....#####.....#####',
      'Q' => '#####.....#####.....#####.....#####.....#####',
      'R' => '#####.....#####.....#####.....#####.....#####',
      'S' => '#####.....#####.....#####.....#####.....#####',
      'T' => '#####.....#####.....#####.....#####.....#####',
      'U' => '#####.....#####.....#####.....#####.....#####',
      'V' => '#####.....#####.....#####.....#####.....#####',
      'W' => '#####.....#####.....#####.....#####.....#####',
      'X' => '#####.....#####.....#####.....#####.....#####',
      'Y' => '#####.....#####.....#####.....#####.....#####',
      'Z' => '#####.....#####.....#####.....#####.....#####',
      '[' => '#####.....#####.....#####.....#####.....#####',
      '\\' => '#####.....#####.....#####.....#####.....#####',
      ']' => '#####.....#####.....#####.....#####.....#####',
      '^' => '#####.....#####.....#####.....#####.....#####',
      '_' => '#####.....#####.....#####.....#####.....#####',
      '`' => '#####.....#####.....#####.....#####.....#####',
      'a' => '#####.....#####.....#####.....#####.....#####',
      'b' => '#####.....#####.....#####.....#####.....#####',
      'c' => '#####.....#####.....#####.....#####.....#####',
      'd' => '#####.....#####.....#####.....#####.....#####',
      'e' => '#####.....#####.....#####.....#####.....#####',
      'f' => '#####.....#####.....#####.....#####.....#####',
      'g' => '#####.....#####.....#####.....#####.....#####',
      'h' => '#####.....#####.....#####.....#####.....#####',
      'i' => '#####.....#####.....#####.....#####.....#####',
      'j' => '#####.....#####.....#####.....#####.....#####',
      'k' => '#####.....#####.....#####.....#####.....#####',
      'l' => '#####.....#####.....#####.....#####.....#####',
      'm' => '#####.....#####.....#####.....#####.....#####',
      'n' => '#####.....#####.....#####.....#####.....#####',
      'o' => '#####.....#####.....#####.....#####.....#####',
      'p' => '#####.....#####.....#####.....#####.....#####',
      'q' => '#####.....#####.....#####.....#####.....#####',
      'r' => '#####.....#####.....#####.....#####.....#####',
      's' => '#####.....#####.....#####.....#####.....#####',
      't' => '#####.....#####.....#####.....#####.....#####',
      'u' => '#####.....#####.....#####.....#####.....#####',
      'v' => '#####.....#####.....#####.....#####.....#####',
      'w' => '#####.....#####.....#####.....#####.....#####',
      'x' => '#####.....#####.....#####.....#####.....#####',
      'y' => '#####.....#####.....#####.....#####.....#####',
      'z' => '#####.....#####.....#####.....#####.....#####',
      '{' => '#####.....#####.....#####.....#####.....#####',
      '|' => '#####.....#####.....#####.....#####.....#####',
      '}' => '#####.....#####.....#####.....#####.....#####',
      '~' => '#####.....#####.....#####.....#####.....#####'
    }.freeze

    def self.font_layer_design_character?(some_design_character)
      some_design_character == '#'
    end

    def self.background_layer_design_character?(some_design_character)
      some_design_character == '.'
    end
  end
  # rubocop: enable Metrics/ModuleLength
end
