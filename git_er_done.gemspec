# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "git_er_done/version"

Gem::Specification.new do |s|
  s.name        = "git_er_done"
  s.version     = Git::Er::Done::VERSION
  s.authors     = ["peakpg"]
  s.email       = ["peakpg@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A gem to assist with git workflow.}
  s.description = %q{A gem to assist with git workflow, similar to git-flow.}

  s.rubyforge_project = "git_er_done"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  [['thor', '~> 0.14.6'], ['grit', '~>2.4']].each do |gem, version|
    s.add_dependency(gem, version)
  end
end
