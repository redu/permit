module Permit
  class Consumer
    def call(metadata, message)
      payload = message[:payload]
      if %w(create remove).include? message[:name]
        coll = Connection.pool.collection('rules')
        policy = Policy.new(:resource_id => payload.delete(:resource_id),
                            :collection => coll)
        policy.send(message[:name], payload)
      end
    end
  end
end
