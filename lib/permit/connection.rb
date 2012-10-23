module Permit
  class Connection
    def self.establish_connections(db_conf, pool_size, environment=Goliath.env)
      @host = db_conf[:host]
      @port = db_conf[:port]
      @db_name = db_conf[:db_name]
      @opts = { :recconnect_in => 1 }
      @opts[:user] = db_conf[:user] if db_conf[:user]
      @opts[:password] = db_conf[:pass] if db_conf[:pass]

      @@connections = EM::Synchrony::ConnectionPool.new(:size => pool_size) do
        conn = EM::Mongo::Connection.new(@host, @port, 1, @opts).db(@db_name)
      end
    end

    def self.pool
      @@connections
    end
  end
end
