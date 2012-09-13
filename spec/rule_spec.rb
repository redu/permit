require 'spec_helper'

module Permit
  describe Rule do
    before(:all) do
      EventMachine.synchrony do
        Permit::Connection.establish_connections(1, "test")
        EM.stop
      end
    end
    around do
      EventMachine.synchrony do
        rules.remove({})
        EM.stop
      end
    end
    let(:db) do
      Permit::Connection.pool
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
          rules.safe_insert(fixtures)
          rule = Rule.new(:resource_id => 'r')
          rule.count.should == 1
          EM.stop
        end
      end

      it "should find data from db" do
        EventMachine.synchrony do
          rules.safe_insert(fixtures)
          rule = Rule.new(:resource_id => 'r')
          rule.find.to_a == fixtures.first.to_a
          EM.stop
        end
      end
    end

    context "inserts" do
      it "should insert rule" do
        EventMachine.synchrony do
          rule = Rule.new(:resource_id => 'r', :subject_id => 's')
          rule.insert(:action => :read)
          rule.count(:actions => { :read => true }).should == 1
          EM.stop
        end
      end
    end
  end
end
