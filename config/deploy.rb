set :application, "HappyShopAPI"
set :repo_url, "git@github.com:kis25791/sephora_test.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/#{fetch(:application)}"
set :deploy_user, khoale

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, "2.3.1"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :all # default value

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push("config/mongoid.yml",
                                                 "config/secrets.yml",
                                                 "config/application.yml")

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push("log",
                                               "bin",
                                               "tmp/pids",
                                               "tmp/cache",
                                               "tmp/sockets",
                                               "vendor/bundle",
                                               "public/system",
                                               "vendor/assets")

# Default value for keep_releases is 5
set :keep_releases, 5
set :keep_assets, 1
