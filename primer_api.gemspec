# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'primer_api/version'

Gem::Specification.new do |spec|
  spec.name          = "primer_api"
  spec.version       = PrimerApi::VERSION
  spec.authors       = ["Adam Carlile"]
  spec.email         = ["adam@benchmedia.co.uk"]
  spec.summary       = %q{Simplifies the process of putting jobs into Primer.}
  spec.description   = %q{Simplifies the process of putting jobs into Primer.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'activemodel'
  spec.add_runtime_dependency 'rest_client'
  spec.add_runtime_dependency 'api-auth'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
