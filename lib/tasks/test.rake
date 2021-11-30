require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['tests/**/*_test.rb']
end

task :default => :test