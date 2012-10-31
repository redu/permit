$:.unshift File.expand_path 'lib'

require 'amqp'
require 'yajl/json_gem'

require 'permit/config'
require 'permit/consumer'
require 'permit/worker'

AMQP.start do |connection|
  EventMachine.synchrony do
    Permit.configure do |c|
      dirname = "#{File.dirname(__FILE__)}/log"
      Dir.mkdir dirname unless File.exists?(dirname)
      c.logger = Logger.new("#{dirname}/permitd_#{c.env}.log")
    end

    channel  = AMQP::Channel.new(connection)
    exchange = channel.topic("permit", :auto_delete => true)
    consumer = Permit::Consumer.new
    worker = Permit::Worker.new(:consumer => consumer, :channel => channel,
                                :exchange => exchange)
    worker.start

    # For testing...
    #
    # EM::add_periodic_timer do
    #   policy = {:resource_id => 'r', :subject_id => 's',
    #             :actions => { :read => true } }
    #   event = { :name => 'create', :payload => policy }

    #   exchange.publish(event.to_json,
    #                    :routing_key => "permit.core")
    # end
  end
end
