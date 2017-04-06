# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'extcite/version'

Gem::Specification.new do |s|
  s.name        = 'extcite'
  s.version     = Extcite::VERSION
  s.date        = '2017-04-06'
  s.summary     = "Citations from PDFs"
  s.description = "Gets DOIS and generates citations for your papers"
  s.authors     = "Scott Chamberlain"
  s.email       = 'myrmecocystus@gmail.com'
  s.homepage    = 'http://github.com/sckott/extcite'
  s.licenses    = 'MIT'

  s.files = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }
  s.require_paths = ["lib"]

  s.bindir      = 'bin'
  s.executables = ['extcite']

  s.add_development_dependency 'bundler', '~> 1.14', '>= 1.14.6'
  s.add_development_dependency 'rake', '~> 12.0', '>= 12.0.0'
  s.add_development_dependency 'test-unit', '~> 3.2', '>= 3.2.1'

  s.add_runtime_dependency 'faraday', '~> 0.12.0.1'
  s.add_runtime_dependency 'faraday_middleware', '~> 0.11.0.1'
  s.add_runtime_dependency 'thor', '~> 0.19.4'
  s.add_runtime_dependency 'pdf-reader', '~> 2.0'
  s.add_runtime_dependency 'oga', '~> 2.2'
  s.add_runtime_dependency 'serrano', '~> 0.3.6'
  s.add_runtime_dependency 'bibtex-ruby', '~> 4.4'
end
