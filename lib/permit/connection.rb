module Permit
  class Connection
    def self.establish_connections(pool_size, environment=Goliath.env)
      @@connections = EM::Synchrony::ConnectionPool.new(:size => pool_size) do
        EM::Mongo::Connection.new.db("permit_#{environment}")
      end
    end

    def self.pool
      @@connections
    end
  end
end
