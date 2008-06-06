# Original code pastie by Christoph Blank http://pastie.org/203129
require File.dirname(__FILE__) + '/rails_helper'

module Hobo; end
module Hobo::Dryml
  extend self

  def find_taglibs(current_file)
    files = []
    if rails_root = RailsHelper.rails_root(current_file)
      files = Dir["#{rails_root}/app/views/#{taglibs_dir_pattern}"] # user taglibs
      if Dir["#{rails_root}/vendor/{plugins,gems}/{hobo,hobo-*}/"].empty? # proj without gem/plugin
        files.concat system_gem_taglibs
      else # proj with gem/plugin
        files.concat Dir["#{rails_root}/vendor/{plugins,gems}/{hobo,hobo-*}/#{taglibs_dir_pattern}"]
      end
    else #  no rails proj
      files.concat system_gem_taglibs
    end
    files.uniq
  end
  
  def system_gem_taglibs
    require 'rubygems'
    gem_path = Gem.source_index.find_name('hobo').last.full_gem_path
    Dir[File.join(gem_path, taglibs_dir_pattern)]
  end
  
  def taglibs_dir_pattern
    '**/taglibs/**/*.dryml'
  end
end