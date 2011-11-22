require 'thor'
require 'git_review'

module GitReview
  class CLI < Thor
    desc "review", "Add note with Reviewed-By: for each commit in current branch."
    def review
      raise "Current branch is master. Exiting..." if git.current_branch == 'master'

      current_branch_commits = git.log.between("master", git.current_branch)
      add_reviewed_by(current_branch_commits)
      push_refs_notes

      system "git log master..#{git.current_branch}"
      display_report(current_branch_commits)
    end

    desc "commits", "Add not with Reviewed-By: for specified commits separated by space."
    def commits(*commits_shas)
      commits = commits_shas.map {|sha| git.object(sha)}
      add_reviewed_by(commits)
      push_refs_notes

      system "git log"
      display_report(commits)
    end


    private

    def add_reviewed_by(commits)
      commits.each do |commit|
        note = "".tap do |msg|
          msg << 'Reviewed-By: '
          msg << "#{git.config('user.name')} <#{git.config('user.email')}>"
        end

        git.lib.add_note(commit, note)
      end
    end

    def push_refs_notes
      system "git push origin refs/notes/*"
    end

    def display_report(commits)
      puts
      say "#{commits.size} commits are marked as reviewed by you.", :green
    end

    def git
      # @git ||= Git.open(".", :log => Logger.new(STDOUT))
      @git ||= Git.open(".")
    end
  end
end
