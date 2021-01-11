# frozen_string_literal: true

require 'ascii_pngfy'

require 'rubygems'
require 'bundler'
Bundler.require(:default, :test)

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
