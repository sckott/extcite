require 'test/unit'
require 'extcite'

require 'simplecov'
SimpleCov.start do
  track_files 'lib/**/*.rb'
  add_filter '/test'
end
if ENV['CI']=='true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end
