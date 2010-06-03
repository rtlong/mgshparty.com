set :scm,         :git
set :repository,  "git@home.rtlong.com:mgshparty.git"
set :branch,      "master"
set :deploy_via,  :remote_cache
set :git_enable_submodules, 1

set :use_sudo, false

default_run_options[:pty] = true  # Must be set for the password prompt from git to work

set :application, "MGSHParty.com"

set :deploy_to,   "/home/me2000r/domains/mgshparty.com/www/"

set :user, 'me2000r'
set :ssh_options, { :forward_agent => true }

server "mgshparty.com", :app, :web, :db

namespace :deploy do
  desc "Restarting Passenger with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
    # Request the page in order to initialize the restart
    `wget "http://mgshparty.com" -O-`
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "Create database.yml in shared/config" 
  after 'deploy:setup' do
    database_configuration = <<-EOF
      login: &login
        adapter: mysql
        host: mysql.rtlong.com
        port: 3306
        username: ryan
        password: seven11

      development:
        database: mgshparty_development
        <<: *login

      test:
        database: mgshparty_test
        <<: *login

      production:
        database: mgshparty
        <<: *login
      EOF

    run "mkdir -p #{deploy_to}/#{shared_dir}/config" 
    put database_configuration, "#{deploy_to}/#{shared_dir}/config/database.yml" 
  end

  desc "Link in the production database.yml" 
  after 'deploy:update_code' do
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml" 
  end
end
