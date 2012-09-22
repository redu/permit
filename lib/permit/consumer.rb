module Permit
  class Consumer
    def call(metadata, message)
      payload = message[:payload]
      coll = Connection.pool.collection('rules')
      policy = Policy.new(:resource_id => payload.delete(:resource_id),
                          :collection => coll)
      policy.create(payload)
    end
  end
end
