unless Object.const_defined?("HOBO_ROOT")
  require "rubygems"
  gem 'hobo'
  require 'hobo' rescue nil
  HOBO_ROOT = $:.find { |path| path =~ %r{/hobo-\d+\.\d+\.\d+/lib} } unless Object.const_defined?("HOBO_ROOT")
end
module Hobo; end

module Hobo::Dryml
  # Extracts the original definition of a tag from its source file
  # Initially, only extracts from taglibs within HOBO_ROOT
  def self.extract_tag(tag_name)
    base_dir = "#{HOBO_ROOT}/taglibs"
    all_dryml_files = Dir[base_dir + "/**/*.dryml"]
    for file in all_dryml_files
      contents = File.read(file).split("\n")
      start_index, end_index, def_count = nil, contents.length - 1, 0
      contents.each_with_index do |line, index|
        if line =~ /<def tag="#{tag_name}"/
          start_index = index
        end
        if start_index
          def_count += 1 if line =~ /<def/
          def_count -= 1 if line =~ %r{</def}
          if def_count == 0
            end_index = index
            return contents[start_index..end_index].join("\n")
          end
        end
      end
    end
    ""
  end
  
  def self.instantiate_tag(tag_name)
    tag_src = extract_tag(tag_name)
    return "" if !tag_src || tag_src.strip == ""
    "<#{tag_name} />\n"
  end
end