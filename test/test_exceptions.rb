# frozen_string_literal: true

require 'testing_prerequisites'

class TestExceptions < Minitest::Test
  def test_that_exceptions_is_defined
    exceptions_defined = defined?(AsciiPngfy::Exceptions)

    refute_nil(exceptions_defined)
  end
end
