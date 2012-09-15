module Permit
  class Consumer
    def call(metadata, payload)
      rule = Rule.new(:resource_id => payload.delete(:resource_id),
                      :subject_id => payload.delete(:subject_id),
                      :logger => Logger.new(STDOUT))
      payload.fetch(:actions, {}).keys.each do |k|
        rule.insert(:action => k)
      end
    end
  end
end
