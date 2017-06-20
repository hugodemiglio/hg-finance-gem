# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hg/finance/version'

Gem::Specification.new do |spec|
  spec.name          = "hg-finance"
  spec.version       = HG::Finance::VERSION
  spec.authors       = ["Hugo Demiglio"]
  spec.email         = ["hugodemiglio@gmail.com"]

  spec.description   = %q{Get brazilian finance data using HG Finance API.}
  spec.summary       = %q{Simple gem to get finance data from HG Finance.}
  spec.homepage      = 'http://hgbrasil.com/finance'
  spec.license       = 'MIT'

  spec.files         = `git ls-files lib`.split($/)
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
end
