require 'spec_helper'

module Permit
  describe Policy do
    let(:db) do
      EM::Mongo::Connection.new.db('permit_test')
    end
    let(:policy) { Policy.new(:db => db, :resource_id => 'r') }
    let(:rules) do
      db.collection("rules")
    end

    context "finders" do
      let(:fixtures) do
        [{ "resource_id" => "r", "subject_id" => "s", "actions" => { "a" => true} },
         { "resource_id" => "t", "subject_id" => "s", "actions" => { "a" => true} }]
      end
      it "should return a instance of rule" do
        EventMachine.synchrony do
          policy.rules.should be_a Rule
          EM.stop
        end
      end

      it "should count the rules" do
        EventMachine.synchrony do
          rules.remove({})
          rules.safe_insert(fixtures)
          policy.rules.count.should == 1
          EM.stop
        end
      end

      it "should return a collection" do
        EventMachine.synchrony do
          rules.remove({})
          rules.safe_insert(fixtures)
          policy.rules.find.should respond_to :map
          EM.stop
        end
      end

      it "should retreive the rules theyselves" do
        EventMachine.synchrony do
          rules.remove({})
          rules.safe_insert(fixtures)
          policy.rules.find.first["resource_id"].should == 'r'
          EM.stop
        end
      end
    end
  end
end
