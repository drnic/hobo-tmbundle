require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/../lib/find_taglibs'

class TestFindTaglibs < Test::Unit::TestCase
  
  context "App using Hobo Gems" do
    setup do
      @rails_root = File.expand_path(File.dirname(__FILE__) + "/fixtures/fixture_apps/app_using_hobo_gems")
      @hobo_gem_root = Gem.source_index.find_name('hobo').last.full_gem_path
    end

    should "find dryml taglibs folders in app and hobo gem" do
      expected = [File.expand_path(File.join(@rails_root, "app/views/taglibs/application.dryml"))] + 
        Dir[File.join(@hobo_gem_root, "**/taglibs/*.dryml")]
      actual = Hobo::Dryml.find_taglibs(@rails_root)
      assert_equal(expected, actual)
    end
  end
  
  context "App using Hobo Plugin" do
    setup do
      @rails_root = File.expand_path(File.dirname(__FILE__) + "/fixtures/fixture_apps/app_using_hobo_plugin")
    end

    should "find dryml taglibs folders in app and hobo plugin" do
      expected = [File.expand_path(File.join(@rails_root, "app/views/taglibs/application.dryml"))] + 
        Dir[File.join(@rails_root, "vendor/plugins/hobo", "**/taglibs/*.dryml")]
      actual = Hobo::Dryml.find_taglibs(@rails_root)
      assert_equal(expected, actual)
    end
  end
  
end