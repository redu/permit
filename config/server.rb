require 'em-synchrony/em-mongo'

$stdout.sync = true

Permit.configure do |c|
  if Goliath.env?(:devel) || Goliath.env?(:test)
    dirname = "#{File.dirname(__FILE__)}/logs"
    Dir.mkdir dirname unless File.exists?(dirname)
    c.logger = Logger.new("#{dirname}/#{Goliath.env}.log")
  end
end

Permit::Connection.establish_connections
config['db'] = Permit::Connection.pool
