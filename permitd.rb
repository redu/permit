require 'bundler/setup'
require 'daemons'

require_relative 'boot'

options = {
  :backtrace  => true,
  :log_output => true,
  :app_name   => 'permit',
  :dir_mode   => :script,
  :dir        => '/tmp/pids',
  :log_dir    => "#{File.expand_path File.dirname __FILE__}/log"
}

Daemons.run("worker.rb", options)
