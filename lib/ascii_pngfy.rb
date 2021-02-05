# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.require(:default)

# Reponsibilities
#   - Top level namespace that contains all AsciiPngfy functionality
#   - Contains general constants
module AsciiPngfy
  MAX_RESULT_PNG_IMAGE_WIDTH = 3840
  MAX_RESULT_PNG_IMAGE_HEIGHT = 2160
  GLYPH_DESIGN_WIDTH = 5
  GLYPH_DESIGN_HEIGHT = 9
  SUPPORTED_ASCII_CODES_WITHOUT_NEWLINE_RANGE = (32..126).freeze
  SUPPORTED_ASCII_CODES_WITHOUT_NEWLINE = SUPPORTED_ASCII_CODES_WITHOUT_NEWLINE_RANGE.to_a.freeze
  SUPPORTED_ASCII_CODES = ([10] + SUPPORTED_ASCII_CODES_WITHOUT_NEWLINE).freeze
  SUPPORTED_ASCII_CHARACTERS = SUPPORTED_ASCII_CODES.map(&:chr).freeze
end

require 'ascii_pngfy/pngfyer'

require 'ascii_pngfy/exceptions'

require 'ascii_pngfy/settings'
require 'ascii_pngfy/settings/configurable_settings'
require 'ascii_pngfy/settings/setable_getable_settings'

require 'ascii_pngfy/settings/setable_getable'
require 'ascii_pngfy/settings/color_setting'
require 'ascii_pngfy/settings/font_height_setting'
require 'ascii_pngfy/settings/horizontal_spacing_setting'
require 'ascii_pngfy/settings/vertical_spacing_setting'
require 'ascii_pngfy/settings/text_setting'

require 'ascii_pngfy/vec2i'
require 'ascii_pngfy/aabb'
require 'ascii_pngfy/rendering_rules'
require 'ascii_pngfy/settings_renderer'

require 'ascii_pngfy/glyphs'
require 'ascii_pngfy/color_rgba'
require 'ascii_pngfy/result'
