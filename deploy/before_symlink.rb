run "echo 'Setting up Monit for Goliath application'"
sudo "cp #{release_path}/deploy/scripts/#{app}_app_wrapper.sh /etc/monit.d/"
sudo "chmod +x /etc/monit.d/#{app}_app_wrapper.sh"
sudo "cp #{release_path}/config/monit/#{app}.monitrc /etc/monit.d/"
