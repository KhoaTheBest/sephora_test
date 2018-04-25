source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# gem 'dotenv-rails', '~> 2.2', '>= 2.2.2'
gem "rails", "~> 5.1.6"
gem 'jbuilder', '~> 2.7'
gem 'secure_headers', '~> 5.0', '>= 5.0.5'
gem 'sidekiq', '~> 5.1', '>= 5.1.3'
gem 'redis-namespace'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~> 1.0', '>= 1.0.2'

# MongoDB Driver
gem 'mongoid', '~> 6.4.0'

# Pagination gem
gem 'kaminari-mongoid', '~> 1.0', '>= 1.0.1'

gem 'httparty', '~> 0.16.2'
gem 'jb'
group :production, :staging do
  gem "unicorn"
  gem "unicorn-worker-killer"
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
  gem "guard", ">= 2.2.2", require: false
  gem "guard-livereload", require: false
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3', require: false
  gem 'faker', '~> 1.8', '>= 1.8.7'
end

group :development do
  gem "annotate", ">= 2.5.0"
  gem "awesome_print"
  gem "bcrypt_pbkdf", require: false
  gem "better_errors"
  gem "binding_of_caller"
  gem "brakeman", require: false
  gem 'bundler-audit', '~> 0.6.0', require: false
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-bundler", "~> 1.3", require: false
  gem "capistrano-mb", ">= 0.33.0", require: false
  gem "capistrano-nc", require: false
  gem "capistrano-rails", require: false
  gem "overcommit", ">= 0.37.0", require: false
  gem "listen", ">= 3.0.5"
  gem "rack-livereload"
  gem "rubocop", ">= 0.53.0", require: false
  gem "spring"
  gem "sshkit", "~> 1.16", require: false
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem 'database_cleaner', '~> 1.6', '>= 1.6.2'
  gem 'mongoid-rspec', '~> 4.0'
  gem 'simplecov', '~> 0.16.1', require: false
  gem 'json_spec', '~> 1.1', '>= 1.1.5'
end
