require_relative 'boot'

class Server < Goliath::API
  def response(env)
    Permit::API.call(env)
  end
end
