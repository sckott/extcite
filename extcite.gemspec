# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'extcite/version'

Gem::Specification.new do |s|
  s.name        = 'extcite'
  s.version     = Extcite::VERSION
  s.date        = '2020-04-15'
  s.summary     = "Citations from PDFs"
  s.description = "Gets DOIS and generates citations for your papers"
  s.authors     = "Scott Chamberlain"
  s.email       = 'myrmecocystus@gmail.com'
  s.homepage    = 'https://github.com/sckott/extcite'
  s.licenses    = 'MIT'

  s.files = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }
  s.require_paths = ["lib"]

  s.bindir      = 'bin'
  s.executables = ['extcite']

  s.add_development_dependency 'bundler', '~> 2.0', '>= 2.0.2'
  s.add_development_dependency 'rake', '~> 13.0', '>= 13.0.1'
  s.add_development_dependency 'test-unit', '~> 3.3', '>= 3.3.4'
  s.add_development_dependency 'simplecov', '~> 0.18.0'
  s.add_development_dependency 'codecov', '~> 0.1.16'

  s.add_runtime_dependency 'timeout', '~> 0.1.0'
  s.add_runtime_dependency 'faraday', '>= 0.15', '< 1.1'
  s.add_runtime_dependency 'faraday_middleware', '>= 0.12.2', '< 1.1.0'
  s.add_runtime_dependency 'thor', '>= 0.20.3', '< 1.1.0'
  s.add_runtime_dependency 'parallel', '~> 1.19'
  s.add_runtime_dependency 'oga', '>= 2.15', '< 4.0'
  s.add_runtime_dependency 'serrano', '>= 0.5.2', '< 0.7.0'
  s.add_runtime_dependency 'bibtex-ruby', '~> 5.0', '>= 5.0.1'
  s.add_runtime_dependency 'pdf-reader', '~> 2.4'

  s.metadata = {
    'homepage_uri' => 'https://github.com/sckott/extcite',
    'changelog_uri' =>
      "https://github.com/sckott/extcite/releases/tag/v#{s.version}",
    'source_code_uri' => 'https://github.com/sckott/extcite',
    'bug_tracker_uri' => 'https://github.com/sckott/extcite/issues',
    'documentation_uri' => 'https://xenodochial-stonebraker-ad2732.netlify.app'
  }
end
