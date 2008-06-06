require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + "/../lib/extract_tag"

class TestTagExtractor < Test::Unit::TestCase
  def setup
    Hobo::Dryml.expects(:find_taglibs).with(__FILE__).returns([File.dirname(__FILE__) + "/fixtures/taglibs/demo.dryml"])
  end

  def test_should_find_one_line_tag
    tag_src = Hobo::Dryml.extract_tag('item', __FILE__)
    expected = '<def tag="item"><% scope.items << parameters.default %></def>'
    assert_not_nil(tag_src)
    assert_equal(expected, tag_src)
  end

  def test_should_find_multiline_tag
    tag_src = Hobo::Dryml.extract_tag('image', __FILE__)
    expected = <<-TAG.strip
<def tag="image" attrs="src">
  <img src="\#{base_url}/images/\#{src}" merge-attrs/>
</def>
TAG
    assert_not_nil(tag_src)
    assert_equal(expected, tag_src)
  end

  def test_should_not_find_xxx
    tag_src = Hobo::Dryml.extract_tag('xxx', __FILE__)
    assert_equal("", tag_src)
  end
  
end