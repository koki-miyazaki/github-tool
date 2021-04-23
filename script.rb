require "rubygems"
require 'bundler/setup'
require 'octokit'

@client = Octokit::Client.new(:access_token => ENV['ACCESS_TOKEN'])

REPO_NAME = ENV['REPO_NAME']

pr_numbers = [7603, 7605, 7611]

# @param pr_numbers [Array] the PR numbers to comment
# @param comment [String] the comment message
def comment_prs(pr_numbers, comment)
  pr_numbers.each do |num|
    comment_url = 'https://api.github.com/repos/' + REPO_NAME + '/issues/' + num.to_s + '/comments'

    res = @client.post(comment_url, body: comment)
  end
end

# @param pr_numbers [Array] the PR numbers to approve
def approve_prs(pr_numbers)
  pr_numbers.each do |num|
    review_url = 'https://api.github.com/repos/' + REPO_NAME + '/pulls/' + num.to_s + '/reviews'

    res = @client.post(review_url, event: 'APPROVE')
  end
end
