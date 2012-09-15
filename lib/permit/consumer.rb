module Permit
  class Consumer
    def call(metadata, payload)
      puts metadata, payload
      payload = JSON.parse(payload, :symbolize_keys => true)
      rule = Rule.new(:resource_id => payload.delete(:resource_id),
                      :subject_id => payload.delete(:subject_id),
                      :logger => Logger.new(STDOUT))
      payload.fetch(:action, {}).keys.each do |k|
        puts "rule.insert"
        rule.insert(:action => k)
      end
    end
  end
end
