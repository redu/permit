require 'em-synchrony/em-mongo'

$stdout.sync = true

Permit.configure do |c|
  dirname = "#{File.dirname(__FILE__)}/log"
  Dir.mkdir dirname unless File.exists?(dirname)
  c.logger = Logger.new("#{dirname}/#{Goliath.env}.log")
end

Permit::Connection.establish_connections
config['db'] = Permit::Connection.pool
