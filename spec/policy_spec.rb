require 'spec_helper'

module Permit
  describe Policy do
    before(:all) do
      EventMachine.synchrony do
        Permit::Connection.establish_connections(1, "test")
        EM.stop
      end
    end
    let(:policy) { Policy.new(:resource_id => 'r') }
    let(:rules) do
      Permit::Connection.pool.collection("rules")
    end

    context "finders" do
      let(:fixtures) do
        [{ "resource_id" => "r", "subject_id" => "s", "actions" => { "a" => true} },
         { "resource_id" => "t", "subject_id" => "s", "actions" => { "a" => true} }]
      end
      around do
        EventMachine.synchrony do
          rules.remove({})
          EM.stop
        end
      end
      it "should return a instance of rule" do
        EventMachine.synchrony do
          policy.rules.should be_a Rule
          EM.stop
        end
      end

      it "should count the rules" do
        EventMachine.synchrony do
          rules.safe_insert(fixtures)
          policy.rules.count.should == 1
          EM.stop
        end
      end

      it "should return a collection" do
        EventMachine.synchrony do
          rules.safe_insert(fixtures)
          policy.rules.find.should respond_to :map
          EM.stop
        end
      end

      it "should retreive the rules theyselves" do
        EventMachine.synchrony do
          rules.safe_insert(fixtures)
          policy.rules.find.first["resource_id"].should == 'r'
          EM.stop
        end
      end
    end
  end
end
