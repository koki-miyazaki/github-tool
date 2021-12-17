require "rubygems"
require 'bundler/setup'
require 'octokit'

@client = Octokit::Client.new(:access_token => ENV['ACCESS_TOKEN'])

REPO_NAME = ENV['REPO_NAME']

# @param pr_numbers [Array] The PR numbers to comment
# @param comment [String] The comment message
def comment_prs(pr_numbers = [], comment)
  pr_numbers.each do |num|
    res = @client.post(comments_url(num), body: comment)
  end
end

# Public: Approve open PRs
#
# @param pr_numbers [Array] The PR numbers to approve
def approve_prs(pr_numbers = [])
  pr_numbers.each do |num|
    next if pr_status(num) != 'open'
    next if latest_review(num)&.state == 'APPROVED'

    res = @client.post(reviews_url(num), event: 'APPROVE')
  end
end

# @return [nil|Hash] The latest review object if exists, nil otherwise.
# @param [String] The pr number to get review of.
def latest_review(pr_num)
  res = @client.get(reviews_url(pr_num))
  res.filter do |review|
    review.user.login == @client.user.login
  end.last
end

def pr_status(pr_num)
  @client.get(pr_url(pr_num))[:state]
end

# e.g. https://api.github.com/repos/some/repo/pulls/123/reviews
def reviews_url(pr_num)
  pr_url(pr_num) + '/reviews'
end

# e.g. https://api.github.com/repos/some/repo/pulls/123
def pr_url(pr_num)
  'https://api.github.com/repos/' + REPO_NAME + '/pulls/' + pr_num.to_s
end

# e.g. https://api.github.com/repos/some/repo/issues/123/comments
def comments_url(pr_num)
  'https://api.github.com/repos/' + REPO_NAME + '/issues/' + pr_num.to_s + '/comments'
end