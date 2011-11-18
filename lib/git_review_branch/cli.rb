require 'thor'
require 'git_review_branch/git_ext'

module GitReviewBranch
  class CLI < Thor
    desc "review", "Add note with Reviewed-By: for each commit in current branch."
    def review
      # git = Git.open(".", :log => Logger.new(STDOUT))
      git = Git.open(".")

      raise "Current branch is master. Exiting..." if git.current_branch == 'master'

      git.log.between("master", git.current_branch).each do |commit|
        note = "".tap do |msg|
          msg << 'Reviewed-By: '
          msg << "#{git.config('user.name')} <#{git.config('user.email')}>"
        end

        git.lib.add_note(commit, note)
      end
    end
  end
end
