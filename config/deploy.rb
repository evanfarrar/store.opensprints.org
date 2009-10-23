set :application, "opensprints store"
set :repository,  "git://github.com/evanfarrar/store.opensprints.org.git"

set :branch, "master"
set :scm_verbose, true 
set :scm, :git

role :web, "store.opensprints.org"                          # Your HTTP server, Apache/etc
role :app, "store.opensprints.org"                          # This may be the same as your `Web` server
role :db,  "store.opensprints.org", :primary => true # This is where Rails migrations will run

set :deploy_to, "/home/efarrar/store.opensprints.org"
set :use_sudo, false
#set :shared_children,  %w(stats.opensprints.org/system stats.opensprints.org/log stats.opensprints.org/pids) 


namespace :deploy do
  task(:start) { }
  task(:stop) { }
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

task :after_update_code do
  # The assets folder must be kept between releases
  run "ln -s #{deploy_to}/#{shared_dir}/assets #{current_release}/public" 
end
