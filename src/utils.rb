require 'cgi'
require 'json'

# prompt for search term
def prompt_search_term
  puts "Welcome to the GitHub Search API!\n\nPlease, enter a search term in order to get the top 10 repositories:"

  gets.chomp
end

# Formaters
def encode_query(query) 
  CGI.escape(query)
end

def format_repositories(repositories) 
  formatted_repositories = repositories.map do |repository|
    { repository: repository['name'], url: repository['html_url'], description: repository['description'], github_username: repository['owner']['login'] }
  end

  return JSON.pretty_generate(formatted_repositories)
end