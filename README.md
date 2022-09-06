
# GitHub Repositories CLI

Find the most relevant repositories on GitHub using a simple command line tool written in Ruby.


https://user-images.githubusercontent.com/58868651/188758761-a0b40eb8-337c-4b02-a7ca-a3f02a68debc.mov


## About 

This simple and efficient CLI program will retrieve your input from the terminal and automatically print the top 10 repositories that match your query ordered by the number of stars. Furthermore, the application keeps track of the number of requests you made and, if you exceed the limit of requests per minute, it will provide you with the necessary information about when you should be able to retry.

## How to run

In order to run the CLI, make sure you have the latest [ruby](https://www.ruby-lang.org/en/downloads/) version installed on your machine.
```
# Clone this repository
$ git clone https://github.com/riltonfranzonee/github-cli

# Enter the project folder
$ cd github-cli

# Install dependencies
$ bundle install

# Start application
scripts/start
```

***Note: If the `scripts/start` is not executable in your machine,  run `chmod u+x scripts/start   ` and you should be good to go***. Alternatively, you can manually run `ruby src/index.rb `.

## Integration tests

The features are thoroughly tested using [rspec](https://rspec.info/) and instead of making real API calls to GitHub in the tests, I'm using [webmock](https://github.com/bblimke/webmock) to stub the responses for each of the scenarios.


https://user-images.githubusercontent.com/58868651/188757994-ee7af199-1fe4-4c0e-bc1c-d8e93da16cac.mov


In order to test it you can simply run:
```
scripts/test
```

***Note: If the `scripts/test` is not executable in your machine,  run `chmod u+x scripts/test   ` and you should be good to go***. Alternatively, you can manually run `bin/rspec --format doc `.


