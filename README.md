# git-review


A git command to add notes with tag 'Reviewed-By: Reviewer <reviewer@example.com>'.

## Setup

  gem install git-review

## Usage

There is two way to use it. First is to mark all commits from current branch as
reviewed.

  git checkout branchname
  git review

Second way is to mark commits individually.

  git review HEAD~1 62ffa0a5
