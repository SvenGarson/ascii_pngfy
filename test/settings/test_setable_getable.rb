# frozen_string_literal: true

require_relative '../testing_prerequisites'

class TestSetableGetable < Minitest::Test
  attr_reader(:test_setting)

  class TestSetting
    include AsciiPngfy::Settings::SetableGetable
  end

  def setup
    @test_setting = TestSetting.new
  end

  def test_that_getable_setable_is_defined
    setable_getable_defined = defined?(AsciiPngfy::Settings::SetableGetable)

    refute_nil(setable_getable_defined)
  end

  def test_that_getable_setable_get_raises_not_implemented_error_if_method_not_overridden
    assert_raises(NotImplementedError) do
      test_setting.get
    end
  end

  def test_that_getable_setable_get_raises_error_with_helpful_error_message_if_method_not_overridden
    test_setting_class_name = test_setting.class.to_s

    expected_error_message = String.new
    expected_error_message << "#{test_setting_class_name}#get has not yet been implemented. "
    expected_error_message << "Must override the #{test_setting_class_name}#get method in order to "
    expected_error_message << 'function as Setting.'

    error_raised = assert_raises(NotImplementedError) do
      test_setting.get
    end

    assert_equal(expected_error_message, error_raised.message)
  end

  def test_that_getable_setable_set_raises_not_implemented_error_if_method_not_overridden
    assert_raises(NotImplementedError) do
      test_setting.set
    end
  end

  def test_that_getable_setable_set_raises_error_with_helpful_error_message_if_method_not_overridden
    test_setting_class_name = test_setting.class.to_s

    expected_error_message = String.new
    expected_error_message << "#{test_setting_class_name}#set has not yet been implemented. "
    expected_error_message << "Must override the #{test_setting_class_name}#set method in order to "
    expected_error_message << 'function as Setting.'

    error_raised = assert_raises(NotImplementedError) do
      test_setting.set
    end

    assert_equal(expected_error_message, error_raised.message)
  end
end
