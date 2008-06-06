require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/../lib/rails_helper'

class TestRailsHelper < Test::Unit::TestCase
  context "Hobo app using Hobo gems" do
    should "find RAILS_ROOT" do
      expected = File.expand_path(File.dirname(__FILE__) + "/fixtures/fixture_apps/app_using_hobo_gems")
      actual = RailsHelper.rails_root(File.join(expected, "app/controllers/application.rb"))
      assert_equal(expected, actual)
    end
  end
  
  context "Random file outside of a Rails app" do
    setup do
      FileUtils.chdir "/tmp"
    end

    should "not find any RAILS_ROOT" do
      assert_nil(RailsHelper.rails_root("/tmp"))
    end
  end
  
  
end