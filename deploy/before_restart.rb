# Restarting Goliath server
sudo "/usr/bin/monit restart #{app}"

# Reconfiguring nginx
run "cp /data/#{app}/current/config/nginx/#{app}.conf /etc/nginx/servers"

# Restarting Permit worker
run "cd #{current_path}; /usr/bin/bundle exec permitd.rb restart"
