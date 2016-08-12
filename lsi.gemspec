# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lsi/version"

Gem::Specification.new do |spec|
  spec.name          = "lsi"
  spec.license=""
  spec.version       = Lsi::VERSION
  spec.authors       = ["Jonathan Hoyt"]
  spec.email         = ["hoyt@github.com"]

  spec.summary       = "Interactively operate on a list"
  spec.description   = "Interactively operate on a list."
  spec.homepage      = "https://github.com/jonmagic/lsi"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "aruba", "~> 0.14"
  spec.add_development_dependency "rake", "~> 11.2"
  spec.add_development_dependency "test-unit", "~> 3.2"
  spec.add_dependency "methadone", "~> 1.9"
end
