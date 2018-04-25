namespace :setup do
  desc "Upload mongoid.yml file."
  task :upload_yml do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/mongoid.yml")), "#{shared_path}/config/mongoid.yml"
      upload! StringIO.new(File.read("config/secrets.yml")), "#{shared_path}/config/secrets.yml"
      upload! StringIO.new(File.read("config/application.yml")), "#{shared_path}/config/application.yml"
    end
  end

  desc "Upload Nginx Config"
  task :upload_nginx do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/nginx_#{fetch(:rails_env)}.conf")), "#{shared_path}/config/nginx_#{fetch(:rails_env)}.conf"
    end
  end

  desc "Upload Unicorn"
  task :upload_unicorn do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/unicorn_init_#{fetch(:rails_env)}.sh")), "#{shared_path}/config/unicorn_init_#{fetch(:rails_env)}.sh"
      upload! StringIO.new(File.read("config/unicorn_#{fetch(:rails_env)}.rb")), "#{shared_path}/config/unicorn_#{fetch(:rails_env)}.rb"
    end
  end

  desc "Seed the database."
  task :seed_db do
    on roles(:app) do
      within current_path.to_s do
        with rails_env: :production do
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc "Symlinks config files for Nginx and Unicorn."
  task :symlink_config do
    on roles(:app) do
      execute "rm -f /etc/nginx/sites-enabled/default"

      execute "ln -nfs #{shared_path}/config/nginx_#{fetch(:rails_env)}.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
      execute "ln -nfs #{shared_path}/config/unicorn_init_#{fetch(:rails_env)}.sh /etc/init.d/unicorn_#{fetch(:application)}"
    end
  end
end
