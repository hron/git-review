# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "git_review/version"

Gem::Specification.new do |s|
  s.name        = "git-review-notes"
  s.version     = GitReview::VERSION
  s.authors     = ["Aleksei Gusev"]
  s.email       = ["aleksei.gusev@gmail.com"]
  s.homepage    = ""
  s.summary     = "Adds git review command."
  s.description = <<-DSC
    git review will add note for each commit in current branch
    with 'Reviewed-By: Reviewer <reviewer@example.com>.'

    git review commits HEAD~1 648dbac marks individual commits as reviewed.
  DSC

  s.rubyforge_project = "git-review-notes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'git'
  s.add_runtime_dependency 'thor'
  s.add_development_dependency "cucumber"
  s.add_development_dependency "aruba", "= 0.4.6"
  s.add_development_dependency "guard-cucumber"
  s.add_development_dependency "active_support"
end
