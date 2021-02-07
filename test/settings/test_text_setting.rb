# frozen_string_literal: false

require 'testing_prerequisites'

class TestTextSetting < Minitest::Test
  attr_reader(:text_setting)

  def setup
    settings = AsciiPngfy::Settings::SetableGetableSettings.new
    @text_setting = AsciiPngfy::Settings::TextSetting.new(settings)
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

  def test_that_text_setting_set_returns_the_same_text_reference_that_is_passed_as_argument
    text = 'Doug Heffernan.'

    returned_text = text_setting.set(text)

    assert_same(text, returned_text)
  end

  def test_that_text_setting_set_returns_text_that_cannot_be_used_to_mutate_internal_state
    returned_text = text_setting.set('I am Superwoman')

    # we want to make sure that the user cannot use the returned reference to change the internal text
    # settings by using string methods directly
    returned_text.replace('Mein Schatz!')

    most_recent_internal_text = text_setting.get

    refute_equal('Mein Schatz!', most_recent_internal_text)
  end

  def test_that_text_setting_get_returns_text_that_reflects_the_last_text_set
    expected_returned_text = 'Leeroy Jenkins'
    text_setting.set(expected_returned_text)

    returned_text = text_setting.get

    assert_equal(expected_returned_text, returned_text)
  end

  def test_that_text_setting_get_returns_text_that_cannot_be_used_to_mutate_internal_state
    text_setting.set('I am Superman')
    returned_text = text_setting.get

    # we want to make sure that the user cannot use the returned reference to change the internal text
    # settings by using string methods directly
    returned_text.replace('I am Super WOMAN')

    most_recent_internal_text = text_setting.get

    refute_equal('I am Super WOMAN', most_recent_internal_text)
  end
end
