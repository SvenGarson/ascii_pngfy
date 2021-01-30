# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.require(:default)

require 'ascii_pngfy/pngfyer'

require 'ascii_pngfy/settings'
require 'ascii_pngfy/settings/setable_getable'
require 'ascii_pngfy/settings/configurable_settings'
require 'ascii_pngfy/settings/setable_getable_settings'
require 'ascii_pngfy/settings/color_setting'
require 'ascii_pngfy/settings/font_height_setting'
require 'ascii_pngfy/settings/horizontal_spacing_setting'
require 'ascii_pngfy/settings/vertical_spacing_setting'
require 'ascii_pngfy/settings/text_setting'

require 'ascii_pngfy/renderer'
require 'ascii_pngfy/vec2i'
require 'ascii_pngfy/aabb'

require 'ascii_pngfy/result'
require 'ascii_pngfy/color_rgba'
require 'ascii_pngfy/exceptions'
require 'ascii_pngfy/glyphs'

# Top level namespace that that contains all AsciiPngfy functionality
module AsciiPngfy; end
