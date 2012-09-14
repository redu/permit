require 'bundler/setup'
require 'goliath'
require 'em-synchrony'
require 'em-synchrony/em-mongo'

module Permit
end

require 'permit/connection'
require 'permit/consumer'
require 'permit/rule'
require 'permit/policy'
require 'permit/api'
