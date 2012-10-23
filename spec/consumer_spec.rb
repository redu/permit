require 'spec_helper'

module Permit
  describe Consumer do
    it "should respondo to #call" do
      EventMachine.synchrony do
        Permit::Consumer.new.should respond_to :call
        EM.stop
      end
    end

    it "should insert rules" do
      EventMachine.synchrony do
        Permit::Connection.establish_connections
        rules = Permit::Connection.pool.collection('rules')
        rules.remove({})
        rule = \
          { :resource_id => 'r', :subject_id => 's', :actions => {:read => true} }
        event = { :name => "create", :payload => rule}
        Permit::Consumer.new.call({}, event)
        rules.count.should == 1
        rules.remove({})
        EM.stop
      end
    end

    it "should insert multiple actions" do
      EventMachine.synchrony do
        Permit::Connection.establish_connections
        rules = Permit::Connection.pool.collection('rules')
        rules.remove({})
        rule = \
          { :resource_id => 'r', :subject_id => 's',
            :actions => {:read => true, :foo => true } }
        event = { :name => "create", :payload => rule}
        Permit::Consumer.new.call({}, event)
        rules.count.should == 1
        rules.remove({})
        EM.stop
      end
    end

    it "should insert the rules correctly" do
      EventMachine.synchrony do
        Permit::Connection.establish_connections
        rules = Permit::Connection.pool.collection('rules')
        rules.remove({})
        r = { :resource_id => 'r', :subject_id => 's', :actions => {:read => true} }
        event = { :name => 'create', :payload => r }
        Permit::Consumer.new.call({}, event)
        docs = rules.find({ :resource_id => 'r' })
        docs.first[:_id].should == r[:_id]
        rules.remove({})
        EM.stop
      end

    end
  end
end
