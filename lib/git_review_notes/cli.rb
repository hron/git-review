require 'thor'
require 'git_review_notes'

module GitReviewNotes
  class CLI < Thor
    desc "review", "Add note with Reviewed-By: for each commit in current branch."
    def review
      raise "Current branch is master. Exiting..." if git.current_branch == 'master'

      current_branch_commits = git.log.between("master", git.current_branch)
      add_reviewed_by(current_branch_commits)

      system "git log master..#{git.current_branch}"
      ask_for_pushing_review(current_branch_commits)
    end

    desc "commits", "Add not with Reviewed-By: for specified commits separated by space."
    def commits(*commits_shas)
      commits = commits_shas.map {|sha| git.object(sha)}
      add_reviewed_by(commits)

      commits_shas.each do |commit_sha|
        system "git log -1 #{commit_sha}"
        puts
      end
      ask_for_pushing_review(commits)
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

    def ask_for_pushing_review(commits)
      puts
      if yes?("Are you sure about to push this review for #{commits.size} commit(s)? [y/N]", :green)
        push_refs_notes
      end
    end

    def git
      # @git ||= Git.open(".", :log => Logger.new(STDOUT))
      @git ||= Git.open(".")
    end
  end
end
