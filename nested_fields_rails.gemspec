# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nested_fields_rails/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'nested_fields_rails'
  s.version       = NestedFieldsRails::VERSION
  
  s.authors       = ["gabriel"]
  s.email         = ["gnaiman@keepcon.com"]
  s.homepage      = 'https://github.com/gabynaiman/nested_fields_rails'
  s.summary       = 'Manage multiple models in the same form'
  s.description   = 'Manage multiple models in the same form'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
