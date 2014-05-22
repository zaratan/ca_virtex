# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ca_virtex/version'

Gem::Specification.new do |spec|
  spec.name          = "ca_virtex"
  spec.version       = CaVirtex::VERSION
  spec.authors       = ["Zaratan"]
  spec.email         = ["denis.pasin@gmail.com"]
  spec.summary       = %q{A gem to map CA Virtex API}
  spec.description   = %q{A gem with a full mapping of CA Virtex API}
  spec.homepage      = "https://github.com/Skizzk/ca_virtex"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'
  spec.add_dependency 'active_support'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
