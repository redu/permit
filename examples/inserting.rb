require 'bundler/setup'
require './boot'
require 'policy'

EM.synchrony do
  Permit::Connection.establish_connections({}, 1, 'development')
  p =  Permit::Policy.new(:resource_id => 'r',
                  :collection => Permit::Connection.pool.collection('rules'))
  p.insert(:subject_id => 's', :actions => { :foo => 'bar' })
end
