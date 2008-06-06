require "rubygems"
require "rake"
require "rake/testtask"

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList[File.dirname(__FILE__) + "/Support/test/test*.rb"]
  t.verbose = true
end