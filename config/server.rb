require 'em-synchrony/em-mongo'

Permit::Config.logger

db_conf = {
  :host => ENV['MONGO_HOST'] || "127.0.0.1",
  :port => ENV['MONGO_PORT'] || "27017",
  :user => ENV['MONGO_USER'],
  :pass => ENV['MONGO_PASS'],
  :db_name => ENV['MONGO_DB_NAME'] || "permit_#{Goliath.env}"
}

Permit::Connection.establish_connections(db_conf, 3)
config['db'] = Permit::Connection.pool
