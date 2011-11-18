# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "git_review_branch/version"

Gem::Specification.new do |s|
  s.name        = "git-review-branch"
  s.version     = GitReviewBranch::VERSION
  s.authors     = ["Aleksei Gusev"]
  s.email       = ["aleksei.gusev@gmail.com"]
  s.homepage    = ""
  s.summary     = "Adds git review-branch command."
  s.description = <<-DSC
    git review-branch will add note for each commit in current branch
    with 'Reviewed-By: Reviewer <reviewer@example.com>.'
  DSC

  s.rubyforge_project = "git-review-branch"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency 'git'
  s.add_runtime_dependency 'thor'
end
