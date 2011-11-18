require 'git'

module GitReviewBranch
  module GitLibExt
    def add_note(commit, note)
      command('notes add -f', ["-m", note, commit.sha])
    end
  end
end

Git::Lib.send(:include, GitReviewBranch::GitLibExt)
