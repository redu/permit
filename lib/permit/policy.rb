module Permit
  class Policy
    def initialize(opts={})
      @db = Connection.pool
      @logger = opts.delete(:logger)
      @filter = opts
    end

    def rules(args={})
      opts = { :db => @db, :logger => @logger }.merge @filter.merge(args)
      Rule.new(opts)
    end
  end
end
