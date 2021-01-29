# frozen_string_literal: true

require_relative 'testing_prerequisites'

class TestGlyphs < Minitest::Test
  ALLOWED_GLYPH_DESIGN_CHARACTERS = %w[. #].freeze

  attr_reader(:supported_ascii_characters_without_newline)

  def setup
    @supported_ascii_characters_without_newline = (32..126).to_a.map(&:chr)
  end

  def test_that_glyphs_is_defined
    glyphs_defined = defined?(AsciiPngfy::Glyphs)

    refute_nil(glyphs_defined)
  end

  def test_that_glyphs_designs_is_defined
    glyphs_designs_defined = defined?(AsciiPngfy::Glyphs::DESIGNS)

    refute_nil(glyphs_designs_defined)
  end

  def test_that_glyphs_designs_has_glyph_design_for_every_supported_non_control_character
    supported_ascii_characters_without_newline.each do |supported_ascii_character|
      error_message = "#{AsciiPngfy::Glyphs}::DESIGNS does not contain a glyph design for the ASCII character "\
                      "#{supported_ascii_character.inspect} with ASCII code #{supported_ascii_character.ord}"

      supported_ascii_character_glyph_design_exists = AsciiPngfy::Glyphs::DESIGNS.key?(supported_ascii_character)

      assert(supported_ascii_character_glyph_design_exists, error_message)
    end
  end

  def test_that_glyphs_designs_has_glyph_design_string_for_every_supported_non_control_character
    supported_ascii_characters_without_newline.each do |supported_ascii_character|
      error_message = "#{AsciiPngfy::Glyphs}::DESIGNS does not contain glyph design string for the ASCII character "\
                      "#{supported_ascii_character.inspect} with ASCII code #{supported_ascii_character.ord}"

      glyph_design_string = AsciiPngfy::Glyphs::DESIGNS[supported_ascii_character]

      assert_instance_of(String, glyph_design_string, error_message)
    end
  end

  def test_that_glyphs_designs_has_glyph_design_for_every_supported_non_control_character_as_45_characters_long_string
    supported_ascii_characters_without_newline.each do |supported_ascii_character|
      error_message = "#{AsciiPngfy::Glyphs}::DESIGNS glyph design string for the ASCII character "\
                      "#{supported_ascii_character.inspect} with ASCII code #{supported_ascii_character.ord} "\
                      'does not have the expected length of 45 characters'

      glyph_design_string = AsciiPngfy::Glyphs::DESIGNS[supported_ascii_character]
      glyph_design_string_length = glyph_design_string.length

      assert_equal(45, glyph_design_string_length, error_message)
    end
  end

  def test_that_glyphs_design_strings_contain_only_allowed_design_characters_for_every_supported_non_control_character
    supported_ascii_characters_without_newline.each do |supported_ascii_character|
      error_message = "#{AsciiPngfy::Glyphs}::DESIGNS glyph design string for the ASCII character "\
                      "#{supported_ascii_character.inspect} with ASCII code #{supported_ascii_character.ord} must "\
                      "contain only the following allowed glyph design characters #{ALLOWED_GLYPH_DESIGN_CHARACTERS}"

      glyph_design_string = AsciiPngfy::Glyphs::DESIGNS[supported_ascii_character]

      glyph_design_string_contains_only_allowed_design_characters = glyph_design_string.chars.all? do |design_character|
        ALLOWED_GLYPH_DESIGN_CHARACTERS.include?(design_character)
      end

      assert(glyph_design_string_contains_only_allowed_design_characters, error_message)
    end
  end
end
