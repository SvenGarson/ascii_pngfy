# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.require(:default)

require 'ascii_pngfy/pngfyer'

require 'settings'
require 'settings/configurable_settings'
require 'settings/setable_getable_settings'
require 'settings/color_setting'
require 'settings/font_height_setting'
require 'settings/horizontal_spacing_setting'
require 'settings/vertical_spacing_setting'
require 'settings/text_setting'

require 'ascii_pngfy/renderer'
require 'ascii_pngfy/color_rgba'
require 'ascii_pngfy/exceptions'

# Top level namespace that that contains all AsciiPngfy functionality
module AsciiPngfy; end
