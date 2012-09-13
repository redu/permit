require 'em-synchrony/em-mongo'

Permit::Connection.establish_connections(3, "development")
config['db'] = Permit::Connection.pool
