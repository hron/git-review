require 'git'

module GitReviewNotes
  module GitLibExt
    def add_note(commit, note)
      command('notes add -f', ["-m", note, commit.sha])
    end
  end
end

Git::Lib.send(:include, GitReviewNotes::GitLibExt)
