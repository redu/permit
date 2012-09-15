require 'spec_helper'

module Permit
  describe Policy do
    context "finders" do
      # let(:policy) { Policy.new(:resource_id => 'r') }
      let(:fixtures) do
        [{ "resource_id" => "r", "subject_id" => "s", "actions" => { "a" => true} },
         { "resource_id" => "t", "subject_id" => "s", "actions" => { "a" => true} }]
      end
      it "should return a instance of rule" do
        EventMachine.synchrony do
          Connection.establish_connections(1)
          rules = Connection.pool.collection("rules")
          policy = Policy.new(:resource_id => 'r')
          policy.rules.should be_a Rule
          EM.stop
        end
      end

      it "should count the rules" do
        EventMachine.synchrony do
          Permit::Connection.establish_connections(1)
          rules = Permit::Connection.pool.collection("rules")
          rules.remove({})
          rules.safe_insert(fixtures)
          policy = Policy.new(:resource_id => 'r')
          policy.rules.count.should == 1
          rules.remove({})
          EM.stop
        end
      end

      it "should return a collection" do
        EventMachine.synchrony do
          Permit::Connection.establish_connections(1)
          rules = Permit::Connection.pool.collection("rules")
          rules.remove({})
          rules.safe_insert(fixtures)
          policy = Policy.new(:resource_id => 'r')
          policy.rules.find.should respond_to :map
          rules.remove({})
          EM.stop
        end
      end

      it "should retreive the rules theyselves" do
        EventMachine.synchrony do
          Permit::Connection.establish_connections(1)
          rules = Permit::Connection.pool.collection("rules")
          rules.remove({})
          rules.safe_insert(fixtures)
          policy = Policy.new(:resource_id => 'r')
          policy.rules.find.first["resource_id"].should == 'r'
          rules.remove({})
          EM.stop
        end
      end
    end
  end
end
