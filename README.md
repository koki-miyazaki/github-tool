GITHUB TOOL
===========

Comment or approve PRs in one time


- Set ACCESS_TOKEN and REPO_NAME environment variables
  - ACCESS_TOKEN should be an access token with `repo` scope: create here https://github.com/settings/tokens
  - REPO_NAME should be like `koki-miyazaki/github-tool`
- Open `irb -r ./gh_tool.rb`
- Approve PRs by `approve_prs([1234])`. Note that 1234 is a PR number to approve.
- Comment PRs by `comment_prs([1234, 5678], 'any comments')`.
