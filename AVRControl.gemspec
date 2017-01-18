# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'AVRControl/version'

Gem::Specification.new do |spec|
  spec.name          = "AVRControl"
  spec.version       = AVRControl::VERSION
  spec.authors       = ["Charlie Meyer"]
  spec.email = ["charlie@charliemeyer.net"]
  spec.summary = %q{A library to control Denon and Marantz audio receivers}
  spec.description = %q{A library to control Denon and Marantz audio receivers}
  spec.homepage = "https://github.com/cemeyer2/AVRControl"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_runtime_dependency 'frisky'
end
