require 'singleton'
require 'configurable'
require 'logger'

module Permit
  def self.configure(&block)
    yield(config)
  end

  def self.config
    @config ||= Config.new
  end

  class Config
    include Configurable
    config :logger, Logger.new(STDOUT)
    config :env, (ENV['RACK_ENV'] || "development").to_sym
    config :db, {
      :host => ENV['MONGO_HOST'] || "127.0.0.1",
      :port => ENV['MONGO_PORT'] || "27017",
      :user => ENV['MONGO_USER'],
      :pass => ENV['MONGO_PASS'],
      :db_name => ENV['MONGO_DB_NAME'] || "permit_development",
      :pool_size => 3
    }
  end
end
