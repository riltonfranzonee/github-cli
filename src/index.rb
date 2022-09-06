require_relative 'api.rb'
require_relative 'utils.rb'

rate_limit = get_rate_limit()

if(rate_limit['remaining'] == 0) then
  available_at = Time.at(rate_limit['reset']).to_s
  puts "You have reached the maximum number of requests per minute. Try again after " + available_at
  return
end

query = prompt_search_term()

if query.empty? then
 puts "You must provide a search term\n"
 return 
end

puts "\nLoading...\n"

repositories = get_github_repositories(query)

if(repositories.length == 0) then
  puts "\n" + 'No repositories were found with the term "' + query + '"'
  return 
end

repositories = format_repositories(repositories)

puts "\n" + 'The following repositories were found with the term "' + query + '":' + "\n"
puts repositories