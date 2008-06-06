require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + "/../lib/extract_tag"

class TestAutocompleteTag < Test::Unit::TestCase
  def setup
    Hobo::Dryml.stubs(:find_taglibs).with(__FILE__).returns([File.dirname(__FILE__) + "/fixtures/taglibs/demo.dryml"])
  end

  def test_no_characters_returns_empty_list
    expected = []
    tag_autocompletion_should_be expected, ""
  end

  def test_invalid_prefix_returns_empty_list
    expected = []
    tag_autocompletion_should_be expected, "xxxxx"
  end

  def test_can_find_single_tag
    expected = %w[one-attribute]
    tag_autocompletion_should_be expected, 'one-att'
    tag_autocompletion_should_be expected, 'one-attribute'
  end

  def test_can_find_multiple_tags
    expected = %w[one-attribute one-anonymous-tag-param one-named-tag-param one-anonymous-placeholder-param]
    tag_autocompletion_should_be expected, 'one-'
    tag_autocompletion_should_be expected, 'one'
  end

  def test_should_return_tags_with_partial_inside
    expected = %w[one-anonymous-tag-param one-anonymous-placeholder-param]
    tag_autocompletion_should_be expected, 'anonymous'
  end

  protected
  def tag_autocompletion_should_be expected, tag_name_partial
    autocompletion_list = Hobo::Dryml.autocomplete_tag(tag_name_partial, __FILE__)
    assert_equal(expected, autocompletion_list)
  end
end