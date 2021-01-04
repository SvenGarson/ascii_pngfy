# frozen_string_literal: true

require_relative 'testing_prerequisites'

class TestRenderer < Minitest::Test
  def test_that_renderer_is_defined
    renderer_defined = defined?(AsciiPngfy::Renderer)

    refute_nil(renderer_defined)
  end

  def test_that_renderer_can_be_instantiated
    renderer = AsciiPngfy::Renderer.new

    assert_instance_of(AsciiPngfy::Renderer, renderer)
  end

  # all methods accepting and returning objects cannot leak these objects
end
