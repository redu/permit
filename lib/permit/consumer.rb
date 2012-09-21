module Permit
  class Consumer
    def call(metadata, message)
      payload = message[:payload]
      rule = Rule.new(:resource_id => payload.delete(:resource_id),
                      :subject_id => payload.delete(:subject_id),
                      :logger => Permit::Config.logger)
      payload.fetch(:actions, {}).keys.each do |k|
        rule.send(message[:name], :action => k)
      end
    end
  end
end
