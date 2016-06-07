# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dozedois/version'

Gem::Specification.new do |s|
  s.name        = 'dozedois'
  s.version     = dozedois::VERSION
  s.date        = '2016-06-07'
  s.summary     = "Gets DOIS and generates citations for your papers"
  s.description = "Gets DOIS and generates citations for your papers"
  s.authors     = "Scott Chamberlain"
  s.email       = 'myrmecocystus@gmail.com'
  s.homepage    = 'http://github.com/sckott/dozedois'
  s.licenses    = 'MIT'

  s.files = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }
  s.require_paths = ["lib"]

  s.bindir      = 'bin'
  s.executables = ['dozedois']

  s.add_development_dependency "bundler", '~> 1.6'
  s.add_development_dependency "rake", '~> 10.4'
  s.add_development_dependency "test-unit", '~> 3.1'
  s.add_development_dependency "oga", '~> 1.2'
  s.add_development_dependency "simplecov", '~> 0.10'
  s.add_development_dependency "codecov", '~> 0.1'

  s.add_runtime_dependency 'faraday', '~> 0.9.1'
  s.add_runtime_dependency 'faraday_middleware', '~> 0.10.0'
  s.add_runtime_dependency 'launchy', '~> 2.4', '>= 2.4.3'
  s.add_runtime_dependency 'pdf-reader','~> 1.3'
  s.add_runtime_dependency 'oga', '~> 1.2'
end
