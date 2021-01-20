# frozen_string_literal: false

require_relative '../testing_prerequisites'

class TestTextSetting < Minitest::Test
  # TextSetting#set
    # return value - test that the final text set (if no error raised) is returned - the value here only for interface purposes
    # leakage - test that the returned text cannot be used to change internal state
  # TextSettings#get
    # no injection - no arguments
    # return value - test that return value is the last text set by #set - just the value for this one
    # leakage- test that the returned text cannot be used to change internal state

  #test_that_color_setting_set_returns_color_rgba_instance_where_color_components_reflect_the_new_internal_color
  #test_that_color_settings_set_returns_color_rgba_instance_that_cannot_be_used_to_mutate_internal_state
  #test_that_color_setting_get_returns_color_rgba_instance_where_color_components_reflect_the_last_color_set
  #test_that_color_settings_get_returns_color_rgba_instance_that_cannot_be_used_to_mutate_internal_state

  attr_reader(:text_setting)

  def setup
    @text_setting = AsciiPngfy::Settings::TextSetting.new
  end

  def test_that_text_setting_set_cannot_be_used_to_inject_text_argument_to_mutate_internal_state
    injected_text = 'I am Iron Man'
    expected_returned_text = 'I am Iron Man'

    # we want to make sure that the text argument cannot be used to inject a reference into the text setting
    # through which we can mutate internal text setting state externally
    text_setting.set(injected_text)
    injected_text.replace('Actually, I am Spiderman')

    returned_text = text_setting.get

    assert_equal(expected_returned_text, returned_text)
  end

  def test_that_text_setting_set_returns_text_that_reflects_the_new_internal_text
    expected_returned_text = 'My name is Bond...'

    returned_text = text_setting.set('My name is Bond...')

    assert_equal(expected_returned_text, returned_text)
  end
end