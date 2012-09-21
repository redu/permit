require 'em-synchrony/em-mongo'

Permit::Config.logger
Permit::Connection.establish_connections(3)
config['db'] = Permit::Connection.pool
