# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "app_parser/version"

Gem::Specification.new do |spec|
  spec.name          = "app_parser"
  spec.version       = AppParser::VERSION
  spec.authors       = ["tkycule"]
  spec.email         = ["tky.cule+github@gmail.com"]

  spec.description   = "Analysis tool for iOS ipa and Android apk."
  spec.summary       = spec.description
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    fail "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", ">= 3.4.0"

  spec.add_dependency "rubyzip"
  spec.add_dependency "CFPropertyList"
  spec.add_dependency "activesupport"
  spec.add_dependency "pngdefry"
  spec.add_dependency "ruby_android"
  spec.add_dependency "image_size"
end
