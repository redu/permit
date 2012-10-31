require_relative 'boot'
require 'permit/api'

class Server < Goliath::API
  def response(env)
    Permit::API.call(env)
  end
end
