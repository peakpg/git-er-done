# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "git-er-done/version"

Gem::Specification.new do |s|
  s.name        = "git-er-done"
  s.version     = Git::Er::Done::VERSION
  s.authors     = ["peakpg"]
  s.email       = ["peakpg@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A gem to assist with git workflow.}
  s.description = %q{A gem to assist with git workflow, similar to git-flow.}

  s.rubyforge_project = "git-er-done"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  [['thor', '>~ 0.14.6'], ['rails', '>~ 3.0.9'].each do |gem, version|
    s.add_dependency(gem, version)
  end
end
