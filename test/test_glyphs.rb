# frozen_string_literal: true

require 'testing_prerequisites'

# rubocop: disable Metrics/ClassLength
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

  def test_that_glyphs_design_strings_are_immutable_for_every_supported_non_control_character
    supported_ascii_characters_without_newline.each do |supported_ascii_character|
      error_message = "#{AsciiPngfy::Glyphs}::DESIGNS glyph design string for the ASCII character "\
                      "#{supported_ascii_character.inspect} with ASCII code #{supported_ascii_character.ord} must "\
                      'be immutable'

      glyph_design_string = AsciiPngfy::Glyphs::DESIGNS[supported_ascii_character]

      assert_raises(FrozenError, error_message) do
        glyph_design_string.replace('#' * 45)
      end
    end
  end

  def test_that_glyphs_designs_cannot_have_new_character_to_glyph_design_key_value_pairs_added
    new_and_unsupported_ascii_character_code = 9
    new_and_unsupported_ascii_character = new_and_unsupported_ascii_character_code.chr
    new_character_glyph_design = ('.' * 45).freeze

    assert_raises(FrozenError) do
      AsciiPngfy::Glyphs::DESIGNS[new_and_unsupported_ascii_character] = new_character_glyph_design
    end
  end

  def test_that_glyphs_designs_cannot_have_existing_character_to_glyph_design_key_value_pairs_deleted
    random_supported_non_control_character = supported_ascii_characters_without_newline.sample

    assert_raises(FrozenError) do
      AsciiPngfy::Glyphs::DESIGNS.delete(random_supported_non_control_character)
    end
  end

  def test_that_glyphs_designs_cannot_have_existing_character_keys_replaced
    existing_character_key = supported_ascii_characters_without_newline.sample

    assert_raises(FrozenError) do
      # the following is really a two step operation
      # first the key/value pair is deleted from the hash and the deleted value is returned
      #
      # then, the same key (in terms of the string value) is added back to the hash and associated
      # with the value that was previously associated to the deleted key
      #
      # so this is really a combination of deleting and adding key/value pairs from the hash
      #
      # for the usage case of this data structure this is sufficient in terms of testing because
      # this is a mistake that could potentially occur in the renderer implementation, where the
      # renderer is supposed to exclusively retrieve the character design strings from the hash
      # and never mutate the hash in any way
      #
      # so this test case is a representation of previous tests but expressed by idiomatic ruby
      # and how this would typically be achieved by non-dynamic language features
      AsciiPngfy::Glyphs::DESIGNS[existing_character_key] = AsciiPngfy::Glyphs::DESIGNS.delete(existing_character_key)
    end
  end

  def test_that_glyphs_designs_cannot_have_existing_character_design_values_replaced
    existing_character_key = supported_ascii_characters_without_newline.sample

    assert_raises(FrozenError) do
      AsciiPngfy::Glyphs::DESIGNS[existing_character_key] = ('.' * 45).freeze
    end
  end

  # rubocop:disable Minitest/AssertTruthy, Minitest/RefuteFalse
  def test_that_glyphs_is_font_layer_design_character_returns_true_when_argument_is_the_hash_character
    hash_character = '#'

    is_font_layer_design_character = AsciiPngfy::Glyphs.font_layer_design_character?(hash_character)

    assert_equal(true, is_font_layer_design_character)
  end

  def test_that_glyphs_is_font_layer_design_character_returns_false_when_argument_is_not_the_hash_character
    background_layer_design_character = '.'

    is_font_layer_design_character = AsciiPngfy::Glyphs.font_layer_design_character?(background_layer_design_character)

    assert_equal(false, is_font_layer_design_character)
  end

  def test_that_glyphs_is_background_layer_design_character_returns_true_when_argument_is_the_period_character
    period_character = '.'

    is_background_layer_design_character = AsciiPngfy::Glyphs.background_layer_design_character?(period_character)

    assert_equal(true, is_background_layer_design_character)
  end

  def test_that_glyphs_is_background_layer_design_character_returns_false_when_argument_is_not_the_period_character
    font_layer_design_character = '#'

    is_background_layer_design_character =
      AsciiPngfy::Glyphs.background_layer_design_character?(font_layer_design_character)

    assert_equal(false, is_background_layer_design_character)
  end
  # rubocop:enable Minitest/AssertTruthy, Minitest/RefuteFalse, Metrics/ClassLength
end
