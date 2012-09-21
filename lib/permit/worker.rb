module Permit
  class Worker
    def initialize(opts)
      @channel = opts[:channel]
      @queue_name = opts[:queue_name] || ""
      @consumer = opts[:consumer] || Consumer.new
      @exchange = opts[:exchange]

      Permit::Connection.establish_connections(1)
      Config.logger.info "Worker initialized and listening"
    end

    def start
      @channel.queue(@queue_name, :exclusive => true) do |queue|
        queue.bind(@exchange, :routing_key => "permit.#").subscribe do |h,p|
          Config.logger.info "Message #{p} with headers #{h} arrived"
          p = JSON.parse(p, :symbolize_keys => true)
          @consumer.call(h,p)
        end
      end
    end
  end
end
