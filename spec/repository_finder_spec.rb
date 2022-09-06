require_relative '../src/features/RepositoryFinder.rb';
require_relative './support/open_file';

MOCKED_RATE_LIMIT = 'mocks/github-rate-limit.json'
MOCKED_RATE_LIMIT_0 = 'mocks/github-rate-limit-0.json'
MOCKED_REPOSITORIES = 'mocks/github-repositories.json'
MOCKED_EMPTY_REPOSITORIES = 'mocks/github-empty-repositories.json'

RATE_LIMIT_URL = GITHUB_URL + '/rate_limit'
REPOSITORIES_URL = GITHUB_URL + '/search/repositories'

describe RepositoryFinder do 
  repositoryFinder = nil

  before(:each) do
    repositoryFinder = RepositoryFinder.new
  end

  describe "when the user hasn't reached the rate limit" do
    before(:each) do
      stub_request(:get, /#{RATE_LIMIT_URL}.*/)
      .to_return(body: open_file(MOCKED_RATE_LIMIT))
    end

    describe 'when no query is provided' do
      it 'prints a message saying that the user must provide a search term' do
         expect do
           repositoryFinder.execute("")
         end.to output(/You must provide a search term/).to_stdout
      end
    end
    describe 'when no results are found' do
      before(:each) do
        stub_request(:get, /#{REPOSITORIES_URL}.*/)
        .to_return(body: open_file(MOCKED_EMPTY_REPOSITORIES))
      end

      it 'prints a message saying that no repositories were found' do
         expect do
           repositoryFinder.execute("RANDOM SEARCH VALUE")
         end.to output(/No repositories were found/).to_stdout
      end
    end

    describe 'when results are found' do
      before(:each) do
        stub_request(:get, /#{REPOSITORIES_URL}.*/)
        .to_return(body: open_file(MOCKED_REPOSITORIES))
      end

      it 'prints a list of objects containing the repository name' do
         expect do
           repositoryFinder.execute("react")
         end.to output(/"repository": /).to_stdout
      end

      it 'prints a list of objects containing the repository url' do
        expect do
          repositoryFinder.execute("react")
        end.to output(/"url": "http/).to_stdout
      end

      it 'prints a list of objects containing the repository description' do
        expect do
          repositoryFinder.execute("react")
        end.to output(/"description":/).to_stdout
      end

      it 'prints a list of objects containing the github_username' do
        expect do
          repositoryFinder.execute("react")
        end.to output(/"github_username":/).to_stdout
      end
    end
  end

  describe "when the user reached the rate limit" do
    before(:all) do
      stub_request(:get,  /#{RATE_LIMIT_URL}.*/)
      .to_return(body: open_file(MOCKED_RATE_LIMIT_0))
    end

    it 'prints a message saying that the user reached the maximum number of requests per minute' do
      expect do
        repositoryFinder.execute("react")
      end.to output(/You have reached the maximum number of requests per minute./).to_stdout
    end
  end
end