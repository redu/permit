require 'em-synchrony'
require 'em-synchrony/em-mongo'

module Permit
  class Rule

    def initialize(opts={})
      @db = Connection.pool
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

    def insert(opts={})
      attr = @filter.merge(opts)
      document = {}
      document[:resource_id] = attr[:resource_id] if attr[:resource_id]
      document[:subject_id] = attr[:subject_id] if attr[:subject_id]
      document[:actions] = {}
      document[:actions][attr[:action]] = true

      @logger.debug "Rule##{__method__} with #{document}" if @logger

      @db.collection.safe_insert(document)
    end
  end
end
