# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "filet/version"

Gem::Specification.new do |s|
  s.name        = "filet"
  s.version     = Filet::VERSION
  s.authors     = ["Jorge Dias", "Jakub Godawa"]
  s.email       = ["jorge@mrdias.com", "jakub.godawa@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Acceptance Testing framework for Test::Unit}
  s.description = %q{Extension for Test::Unit to have a Steak-like DSL for acceptance testing}

  s.add_development_dependency "rake"
  s.add_development_dependency "activesupport"
  s.add_development_dependency "i18n"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
