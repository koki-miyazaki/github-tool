GITHUB TOOL
===========

comment or approve PRs in one time


- set ACCESS_TOKEN and REPO_NAME environment variables
  - ACCESS_TOKEN should be an access token with `repo` scope: create here https://github.com/settings/tokens
  - REPO_NAME should be like `koki-miyazaki/github-tool`
- open `irb`
- type `require './script.rb'`
- set pr_numbers as you like `pr_numbers = (2000..2010).map(&:to_i)`
- type `comment_prs(pr_numbers, 'any comments')` or `approve_prs(pr_numbers)`
