require 'active_support/core_ext/kernel/reporting'

Before do
  setup_sample_repository
  @dirs = ["tmp/aruba/workcopy"]
end

def setup_sample_repository
  silence_stream(STDERR) do
    silence_stream(STDOUT) do
      system <<-SHELL
        rm -rf tmp/aruba
        mkdir -p tmp/aruba/origin

        cd tmp/aruba/origin
        git init --bare
        cd ..

        git clone origin/ workcopy/
        cd workcopy
        pwd

        git config --add user.name Reviewer
        git config --add user.email reviewer@example.com

        touch README
        git add README
        git commit -m 'first commit.'
        touch Gemfile
        git add Gemfile
        git commit -m 'second commit.'
        git push origin master

        git branch branch-for-review
        git checkout branch-for-review
        touch file1
        git add file1
        git commit -m 'commit 1 in branch-for-review.'
        touch file2
        git add file2
        git commit -m 'commit 2 in branch-for-review.'
        git push origin branch-for-review

        git checkout master
  SHELL
    end
  end
end
