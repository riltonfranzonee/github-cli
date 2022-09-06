require_relative 'features/RepositoryFinder.rb'

repository_finder = RepositoryFinder.new

query = prompt_search_term()

repository_finder.execute(query)


