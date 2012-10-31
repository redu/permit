require 'bundler/setup'
require 'em-synchrony'
require 'em-synchrony/em-mongo'

module Permit
end

require 'permit/config'
require 'permit/connection'
require 'permit/consumer'
require 'permit/policy'
require 'permit/worker'
