module Permit
  class Rule
    def initialize(opts={})
      @db = opts.delete(:db)
      @logger = opts.delete(:logger)
      @filter = opts
    end

    def find(opts={})
      @logger.debug "Rule##{__method__} with #{@filter.merge(opts)}" if @logger
      @db.collection('rules').find(@filter.merge(opts))
    end

    def count(opts={})
      @logger.debug "Rule##{ __method__} with #{@filter.merge(opts)}" if @logger
      find(@filter.merge(opts)).count
    end
  end
end
