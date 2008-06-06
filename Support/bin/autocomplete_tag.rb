#!/usr/bin/env ruby

begin
  require ENV['TM_SUPPORT_PATH'] + "/lib/ui"
rescue LoadError
  puts <<-EOS
This command requires TextMate's edge Support folder.
Replace ~/Library/Application Support/TextMate/Support
With: http://macromates.com/svn/Bundles/trunk/Support

  cd ~/Library/Application\ Support/TextMate/
  rm -rf Support
  svn co http://macromates.com/svn/Bundles/trunk/Support
  EOS
  exit
end

require File.dirname(__FILE__) + '/../lib/extract_tag'
tag_name_partial = ENV['TM_SELECTED_TEXT'] || ENV['TM_CURRENT_WORD']
list = Hobo::Dryml.autocomplete_tag(tag_name_partial, ENV['TM_FILEPATH'])
result = TextMate::UI.request_item(:items => list.uniq.sort, :title => 'Select Hobo tag:')
print result || list.inspect || tag_name_partial
