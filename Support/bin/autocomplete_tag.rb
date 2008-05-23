#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../lib/extract_tag'
tag_name_prefix = ENV['TM_SELECTED_TEXT'] || ENV['TM_CURRENT_WORD']
list = Hobo::Dryml.autocomplete_tag(tag_name_prefix)
puts list.join(", ")

# TODO - popup a drop-down list for selection; and apply selected tag to #instantiate_tag