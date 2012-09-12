$:.unshift File.expand_path 'lib'

require 'permit'

class Server < Goliath::API
  def response(env)
    env.logger.info db
    env["db"] = db
    Permit::API.call(env)
  end
end
