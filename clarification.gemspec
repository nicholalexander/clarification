# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "clarification/version"

Gem::Specification.new do |spec|
  spec.name          = "clarification"
  spec.version       = Clarification::VERSION
  spec.authors       = ["Nichol Alexander"]
  spec.email         = ["nichol.alexander@gmail.com"]

  spec.summary       = %q{An unofficial API wrapper for the Clarifai Image and Video Recognition API.}
  spec.description   = %q{Alpha Version - Predict and Search using Clarifai.}
  spec.homepage      = "https://github.com/nicholalexander/clarification"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>=2.2'

  spec.add_runtime_dependency "json"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "codacy-coverage"
  
end
