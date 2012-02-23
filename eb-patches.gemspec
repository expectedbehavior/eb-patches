# -*- encoding: utf-8 -*-
$LOAD_PATH.push(File.expand_path "../lib", __FILE__)
require "eb-patches/version"

Gem::Specification.new do |gem|
  gem.authors       = ["Joel Meador"]
  gem.email         = ["joel@expectedbehavior.com"]
  gem.description   = %q{Various patches to core libs that are useful in many projects.}
  gem.summary       = %q{Patches!}
  gem.homepage      = "http://www.expectedbehavior.com"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "eb-patches"
  gem.require_paths = ["lib"]
  gem.version       = Eb::Patches::VERSION

  gem.add_dependency "activesupport"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "minitest"
end
