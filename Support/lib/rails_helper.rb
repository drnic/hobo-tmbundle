module RailsHelper
  extend self
  
  def rails_root(path)
    path = File.expand_path(path || ".")
    path = File.dirname(path) if File.file?(path)
    return nil if path.length <= 1
    if File.exists?("#{path}/config/boot.rb") and File.read("#{path}/config/boot.rb").match(/RAILS_ROOT/)
      return path
    end
    rails_root(File.dirname(path))
  end
end