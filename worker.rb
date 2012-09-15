require_relative 'boot'
require 'amqp'
require 'yajl/json_gem'

AMQP.start do |connection|

  EventMachine.synchrony do
    channel  = AMQP::Channel.new(connection)
    exchange = channel.topic("permit", :auto_delete => true)
    consumer = Permit::Consumer.new
    worker = Permit::Worker.new(:consumer => consumer, :channel => channel,
                                :exchange => exchange)
    worker.start

    EM::add_periodic_timer do
      exchange.publish({:resource_id => 'r', :subject_id => 's',
                        :action => { :read => true } }.to_json,
                        :routing_key => "permit.core")
    end
  end
end
