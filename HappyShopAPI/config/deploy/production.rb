set :stage, :production
set :rails_env, :production
set :bundle_flags, '--deployment'

server "206.189.38.24",
       user: "khoale",
       roles: %w[web app db],
       primary: true
