Feature: Adding 'Reviewed-By:' note for reviewed commits

  To have some formal way to see that particular git commits was reviewed by a developer
  we need some tool that allows us to easily add a git note for each reviewed commit.

  Scenario: Review a branch
    When I run `git checkout branch-for-review`
    And I run `git log`
    Then the output should not contain "Reviewed-By:"
    When I run `git review-branch`
    Then the output should contain "Reviewed-By: Reviewer <reviewer@example.com>"
    And the output should contain "2 commits are marked as reviewed by you."