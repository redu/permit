module Permit
  class Config
    def self.logger(logger=nil)
      l = logger || Logger.new("logs/#{Goliath.env}.log")
      @@logger ||= l
    end
  end
end
