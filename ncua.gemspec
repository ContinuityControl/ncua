# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ncua/version'

Gem::Specification.new do |spec|
  spec.name          = "ncua"
  spec.version       = NCUA::VERSION
  spec.authors       = ["Tom Reznick"]
  spec.email         = ["treznick@continuty.net"]

  spec.summary       = %q{A Ruby client for the NCUA's "Find a Credit Union tool"}
  spec.description   = %q{The NCUA recently started using asynchronous json requests in their Find a Credit Union tool. We make that query-able from Ruby.}
  spec.homepage      = "https://github.com/ContinuityControl/ncua"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) } + Dir['./lib/tasks/*.rake']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "httparty", "~> 0.13"
  spec.add_runtime_dependency 'nokogiri', '~> 1.6', '>= 1.6.0'
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug", "~> 8.0"
end
