#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../lib/extract_tag'
puts Hobo::Dryml.extract_tag(ENV['TM_SELECTED_TEXT'])
