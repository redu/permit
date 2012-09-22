require_relative 'boot'
require 'amqp'
require 'yajl/json_gem'

AMQP.start do |connection|

  EventMachine.synchrony do
    Goliath.env = :development
    channel  = AMQP::Channel.new(connection)
    exchange = channel.topic("permit", :auto_delete => true)
    consumer = Permit::Consumer.new
    worker = Permit::Worker.new(:consumer => consumer, :channel => channel,
                                :exchange => exchange)
    worker.start

    # EM::add_periodic_timer do
    #   policy = {:resource_id => 'r', :subject_id => 's',
    #             :actions => { :read => true } }
    #   event = { :name => 'create', :payload => policy }

    #   exchange.publish(event.to_json,
    #                    :routing_key => "permit.core")
    # end
  end
end
