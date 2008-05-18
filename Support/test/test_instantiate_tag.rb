require "test/unit"
HOBO_ROOT = File.dirname(__FILE__) + "/../fixtures"
require File.dirname(__FILE__) + "/../lib/extract_tag"

class TestInstantiateTag < Test::Unit::TestCase
  def test_should_support_tag_with_no_param
    expected = "<no-param />\n"
    tag_should_instantiate_to_be('no-param', expected)
  end

  def test_should_support_one_attribute
    expected = %Q{<one-attribute${1: attr1="${2:attr1}"} />\n}
    tag_should_instantiate_to_be('one-attribute', expected)
  end

  def test_should_support_many_attributes
    expected = %Q{<three-attributes${1: attr1="${2:attr1}"}${3: attr2="${4:attr2}"}${5: attr3="${6:attr3}"} />\n}
    tag_should_instantiate_to_be('three-attributes', expected)
  end

  def test_should_return_empty_string_if_invalid_tag
    tag_should_instantiate_to_be('xxx', '')
  end

  protected
  def tag_should_instantiate_to_be(tag_name, expected)
    tag_src = Hobo::Dryml.instantiate_tag(tag_name)
    assert_equal(expected, tag_src)
  end
end
