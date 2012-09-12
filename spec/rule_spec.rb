require 'spec_helper'

module Permit
  describe Rule do
    let(:db) do
      EM::Mongo::Connection.new.db('permit_test')
    end
    let(:rules) do
      db.collection("rules")
    end

    context "finders" do
      let(:fixtures) do
        [{ :resource_id => "r", :subject_id => "s", :actions => { :a => true} },
         { :resource_id => "t", :subject_id => "s", :actions => { :a => true} }]
      end
      it "should count data from db" do
        EventMachine.synchrony do
          rules.remove({})
          rules.safe_insert(fixtures)
          rule = Rule.new(:db => db, :resource_id => 'r')
          rule.count.should == 1
          EM.stop
        end
      end

      it "should find data from db" do
        EventMachine.synchrony do
          rules.remove({})
          rules.safe_insert(fixtures)
          rule = Rule.new(:db => db, :resource_id => 'r')
          rule.find.to_a == fixtures.first.to_a
          EM.stop
        end
      end
    end
  end
end
