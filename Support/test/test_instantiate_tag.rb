require "test/unit"
HOBO_ROOT = File.dirname(__FILE__) + "/../fixtures"
require File.dirname(__FILE__) + "/../lib/extract_tag"

class TestInstantiateTag < Test::Unit::TestCase
  def test_should_support_tag_with_no_param
    tag_src = Hobo::Dryml.instantiate_tag('no_param')
    expected = <<-RUN_TAG
<no_param />
RUN_TAG
    assert_equal(expected, tag_src)
  end

  def test_should_return_empty_string_if_invalid_tag
    tag_src = Hobo::Dryml.instantiate_tag('xxx')
    assert_equal("", tag_src)
  end
end
