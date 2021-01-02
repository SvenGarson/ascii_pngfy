# frozen_string_literal: true

require_relative 'testing_prerequisites'

class TestRenderer < Minitest::Test
  def test_that_renderer_is_defined
    renderer_defined = defined?(AsciiPngfy::Renderer)

    refute_nil(renderer_defined)
  end

=begin
  > Things to test_
    - instantiate the Renderer
    - Default/init values after instantiation
    - setting the attributes
    - return values of attribute setters
    - 
    - Instantiating the Renderer
    - Default/Init value before setting attributes
    > Attribute setters methods:
      - using the setter as intended
      - argument combinations
      - argument types and associated errors
      - argument ranges and associated errors
      - expected setter return value
=end
end
