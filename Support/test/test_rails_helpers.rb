require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/../lib/rails_helper'

class TestRailsHelper < Test::Unit::TestCase
  context "Hobo app using Hobo gems" do
    setup do
      @expected_rails_root = File.expand_path(File.dirname(__FILE__) + "/fixtures/fixture_apps/app_using_hobo_gems")
      FileUtils.chdir @expected_rails_root
    end

    should "find RAILS_ROOT" do
      actual = RailsHelper.rails_root(File.join(@expected_rails_root, "app/controllers/application.rb"))
      assert_equal(@expected_rails_root, actual)
    end
  end
  
end