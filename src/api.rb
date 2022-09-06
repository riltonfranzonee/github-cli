require 'rest-client'
require 'json'

GITHUB_URL = "https://api.github.com";

def get_github_repositories(query) 
  response = RestClient.get(GITHUB_URL + '/search/repositories', { params: { q: encode_query(query), sort: 'stars', order: 'desc', per_page: 10, page: 1 }});

  parsed_response = JSON.parse(response)

  parsed_response['items']
end

def get_rate_limit 
  response = RestClient.get(GITHUB_URL + '/rate_limit')

  parsed_response = JSON.parse(response)

  parsed_response['resources']['search']
end