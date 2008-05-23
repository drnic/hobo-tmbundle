unless Object.const_defined?("HOBO_ROOT")
  require "rubygems"
  gem 'hobo'
  require 'hobo' rescue nil
  HOBO_ROOT = $:.find { |path| path =~ %r{/hobo-\d+\.\d+\.\d+/lib} } unless Object.const_defined?("HOBO_ROOT")
end
module Hobo; end

module Hobo::Dryml
  extend self

  # Extracts the original definition of a tag from its source file
  # Initially, only extracts from taglibs within HOBO_ROOT
  def extract_tag(tag_name)
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

  def instantiate_tag(tag_name)
    tag_src = extract_tag(tag_name)
    return "" if !tag_src || tag_src.strip == ""
    attrs_snippets = attrs_snippets_from tag_src, tag_name
    param_list = param_list_from tag_src, tag_name
    if !param_list || param_list.length == 0
      "<#{tag_name}#{attrs_snippets}>$0</#{tag_name}>\n"
    else
      "<#{tag_name}#{attrs_snippets}>\n" +
        param_list.map do |indent, param_name|
          "#{indent}<#{param_name}:></#{param_name}:>\n"
        end.join +
      "</#{tag_name}>\n"
    end
  end

  def autocomplete_tag(tag_name_partial)
    return [] if tag_name_partial.strip.length == 0
    base_dir = "#{HOBO_ROOT}/taglibs"
    all_dryml_files = Dir[base_dir + "/**/*.dryml"]
    all_dryml_files.inject([]) do |list, file|
      contents = File.read(file).split("\n")
      contents.each_with_index do |line, index|
        matches = line.match(/<def tag="([^"]*#{tag_name_partial}[^"]*)"/)
        list << matches[1] if matches && matches[1]
      end
      list
    end
  end

  protected
  def attrs_snippets_from tag_src, tag_name
    attrs_snippets = ""
    attrs_match = tag_src.match(%r{def tag="#{tag_name}"\s+attrs="([^"]+)"})
    if attrs_match
      attr_names = attrs_match[1].split(/\s*,\s*/)
      attrs_snippets = attr_names.inject([]) do |list, attr|
        index = list.size * 2 + 1
        list << %Q{${#{index}: #{attr}="${#{index+1}:#{attr}}"}}
        list
      end.join
    end
    attrs_snippets
  end

  def param_list_from tag_src, tag_name
    matches = tag_src.scan(%r{([\s\t]*)<([\w\-_]+):?\s+.*param(?:\s|/|>|="([^"]+)")})
    # just the name of the param (either an explicit name or the element name)
    matches.map do |match_array|
      indent, *names = match_array.reject { |item| item.nil? }
      [indent.gsub("\n",''), names.last]
    end
  end
end