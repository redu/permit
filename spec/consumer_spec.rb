require 'spec_helper'

module Permit
  describe Consumer do
    it "should respondo to #handle_message" do
      EventMachine.synchrony do
        Permit::Consumer.new.should respond_to :handle_message
        EM.stop
      end
    end

    it "should insert rules" do
      EventMachine.synchrony do
        Permit::Connection.establish_connections(1, "test")
        rules = Permit::Connection.pool.collection('rules')
        rules.remove({})
        Permit::Consumer.new.handle_message({}, { :resource_id => 'r', :subject_id => 's', :actions => {:read => true} })
        rules.count.should == 1
        rules.remove({})
        EM.stop
      end
    end

    it "should insert multiple actions" do
      EventMachine.synchrony do
        Permit::Connection.establish_connections(1, "test")
        rules = Permit::Connection.pool.collection('rules')
        rules.remove({})
        Permit::Consumer.new.handle_message({}, { :resource_id => 'r', :subject_id => 's', :actions => {:read => true, :foo => true} })
        rules.count.should == 2
        rules.remove({})
        EM.stop
      end
    end

    it "should insert the rules correctly" do
      EventMachine.synchrony do
        Permit::Connection.establish_connections(1, "test")
        rules = Permit::Connection.pool.collection('rules')
        rules.remove({})
        r = { :resource_id => 'r', :subject_id => 's', :actions => {:read => true} }
        Permit::Consumer.new.handle_message({}, r)
        docs = rules.find({ :resource_id => 'r' })
        docs.first[:_id].should == r[:_id]
        rules.remove({})
        EM.stop
      end

    end
  end
end
