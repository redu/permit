module Permit
  class Connection
    def self.establish_connections
      @host = Permit.config.db.host
      @port = Permit.config.db.port
      @db_name = Permit.config.db.db_name
      @opts = { :recconnect_in => 1 }
      @user = Permit.config.db.user if Permit.config.db.user
      @password = Permit.config.db.pass if Permit.config.db.pass

      @@conns = \
        EM::Synchrony::ConnectionPool.new(:size => Permit.config.db.pool_size) do
        conn = EM::Mongo::Connection.new(@host, @port, 1, @opts)
        db = conn.db(@db_name)
        db.authenticate(@user, @password) if @user && @password
        db
      end
    end

    def self.pool
      @@conns
    end
  end
end
