# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.require(:default)

require 'ascii_pngfy/pngfyer'
require 'ascii_pngfy/settings'
require 'ascii_pngfy/renderer'
require 'ascii_pngfy/color_rgba'
require 'ascii_pngfy/exceptions'

# Top level namespace that that contains all AsciiPngfy functionality
module AsciiPngfy; end
