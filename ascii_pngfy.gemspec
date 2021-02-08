# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.required_ruby_version = '~>2.7.2'
  spec.name = 'ascii_pngfy'
  spec.version = '0.2.0'
  spec.summary = 'Ruby Gem that renders ASCII text into PNGs using a 5x9 monospaced font.'
  spec.description = [
    'AsciiPngfy is a Ruby Gem that enables you to render ASCII text into a PNG image up to a resolution of 3840(width)',
    'by 2160(height) using a 5x9 monospaced font. Configurable settings that influence   the result are font-color,',
    'background-color, font-height, horizontal-spacing, vertical-spacing, and text.',
    'The result includes the PNG containing the intended image with all the settings applied, a snapshot of the',
    'settings used, and render dimensions that define the size the generated png should be rendered at to reflect the',
    'font-height settings. The generated png is always the lowest possible resolution. Each monospaced character takes',
    'up a 5(width) by 9(height) space to take advantage of scaled rendering and avoid unnecessarily large images.',
    'For the best visual results, the resulting png should be rendered in the original dimensions or the render',
    'dimensions along with a NEAREST filter.'
  ].join(' ')

  spec.authors = ['Sven Garson']
  spec.email = 'sven.garson@outlook.com'
  spec.files = Dir['lib/**/*.rb']
  spec.homepage = 'https://github.com/SvenGarson/ascii_pngfy'
  spec.license = 'MIT'

  spec.add_runtime_dependency('chunky_png', '1.4.0')

  spec.add_development_dependency('minitest', '5.14.3')
  spec.add_development_dependency('minitest-reporters', '1.4.3')
  spec.add_development_dependency('rake', '13.0.3')
  spec.add_development_dependency('rubocop', '1.9.1')
  spec.add_development_dependency('rubocop-minitest', '0.10.3')
end
