sudo "/usr/bin/monit restart #{app}"
run "cp /data/#{app}/current/config/nginx/#{app}.conf /etc/nginx/servers"
