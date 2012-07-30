# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nested_fields/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["gabriel"]
  gem.email         = ["gnaiman@keepcon.com"]
  gem.description   = 'Manage multiple models the same form'
  gem.summary       = 'Manage multiple models the same form'
  gem.homepage      = 'https://github.com/gabynaiman/nested_fields'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nested_fields"
  gem.require_paths = ["lib"]
  gem.version       = NestedFields::VERSION
end
