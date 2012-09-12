require 'em-synchrony/em-mongo'

config['db'] = EM::Synchrony::ConnectionPool.new(:size => 3) do
  connection = EM::Mongo::Connection.new.db('permit_development')
end
