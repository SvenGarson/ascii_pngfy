# frozen_string_literal: true

Gem::Specification.new do |s|
  s.required_ruby_version = '~> 2.7.2'
  s.name        = 'ascii_pngfy'
  s.version     = '0.1.0'
  s.license     = 'MIT'
  s.summary     = 'Renders ASCII text into PNGs using a 5x9 monospaced font.'
  s.description = <<-HEREDOC
    Generate a PNG image that contains a graphical representation of Ascii characters in the
    range (32..126) using a monospaced font with a glyph resolution of 5 wide by 9 high.

    Options that can be specified to alter the generated PNG are:
      - Font color
      - Background color
      - Font size
      - Vertical and horizontal spacing
      - Text to render
      - Optional sanitization of unsupported characters

    The purpose is to generate the lowest resolution PNG possible and render said PNG
    to scale with nearest filters to minimize texture resolution for the exact same result
    as with a bigger texture.
  HEREDOC
  s.authors     = ['Sven Garson']
  s.email       = 'garson_sven@hotmail.com'
  s.files       = ['lib/ascii_pngfy.rb']
  s.homepage    = 'https://github.com/SvenGarson/ascii_pngfy'
  s.metadata    = { 'source_code_uri' => 'https://github.com/SvenGarson/ascii_pngfy' }
  s.add_runtime_dependency 'chunky_png', '1.4.0'
end
