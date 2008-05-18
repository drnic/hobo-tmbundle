require 'test/unit'
HOBO_ROOT = File.dirname(__FILE__) + "/../fixtures" unless Object.const_defined?("HOBO_ROOT")
require File.dirname(__FILE__) + "/../lib/extract_tag"

class TestTagExtractor < Test::Unit::TestCase
  def test_should_find_one_line_tag
    tag_src = Hobo::Dryml.extract_tag('item')
    expected = '<def tag="item"><% scope.items << parameters.default %></def>'
    assert_not_nil(tag_src)
    assert_equal(expected, tag_src)
  end

  def test_should_find_multiline_tag
    tag_src = Hobo::Dryml.extract_tag('image')
    expected = <<-TAG.strip
<def tag="image" attrs="src">
  <img src="\#{base_url}/images/\#{src}" merge-attrs/>
</def>
TAG
    assert_not_nil(tag_src)
    assert_equal(expected, tag_src)
  end

  def test_should_not_find_xxx
    tag_src = Hobo::Dryml.extract_tag('xxx')
    assert_equal("", tag_src)
  end
end