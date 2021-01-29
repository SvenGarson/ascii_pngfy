# frozen_string_literal: true

require_relative 'testing_prerequisites'

class TestGlyphs < Minitest::Test
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

  def test_that_glyphs_designs_has_glyph_design_string_for_every_supported_non_control_character
    supported_ascii_characters_without_newline.each do |supported_ascii_character|
      error_message = "#{AsciiPngfy::Glyphs}::DESIGNS does not contain glyph design string for the ASCII character "\
                      "#{supported_ascii_character.inspect} with ASCII code #{supported_ascii_character.ord}."

      supported_ascii_character_glyph_design_exists = AsciiPngfy::Glyphs::DESIGNS.key?(supported_ascii_character)

      assert(supported_ascii_character_glyph_design_exists, error_message)
    end
  end
end
