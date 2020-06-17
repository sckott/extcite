require 'test/unit'
require 'extcite'

require 'simplecov'
SimpleCov.start 
if ENV['CI']=='true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end
# do
#   track_files 'lib/**/*.rb'
#   add_filter '/test'
# end
