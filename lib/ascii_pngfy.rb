# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.require(:default)

require_relative 'ascii_pngfy/renderer'
require_relative 'ascii_pngfy/renderer_settings'
require_relative 'ascii_pngfy/color_rgba'

# Top level namespace that that contains all AsciiPngfy functionality
module AsciiPngfy; end
