#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../lib/extract_tag'
tag_name = ENV['TM_SELECTED_TEXT']
puts Hobo::Dryml.instantiate_tag(tag_name)
