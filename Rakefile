require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test-*.rb']
  t.verbose = true
  t.warning = false
end

desc "Run tests"
task :default => :test

desc "Build extcite docs"
task :docs do
	system "yardoc"
end

desc "bundle install"
task :bundle do
  system "bundle install"
end

desc "clean out builds"
task :clean do
  system "ls | grep [0-9].gem | xargs rm"
end

desc "Build extcite"
task :build do
	system "gem build extcite.gemspec"
end

desc "Install extcite"
task :install => [:bundle, :build] do
	system "gem install extcite-#{Extcite::VERSION}.gem"
end

desc "Release to Rubygems"
task :release => :build do
  system "gem push extcite-#{Extcite::VERSION}.gem"
end
