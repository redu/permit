require 'spec_helper'

module Permit
  describe Policy do
    context "finders" do
      # let(:policy) { Policy.new(:resource_id => 'r') }
      let(:fixtures) do
        [{ "resource_id" => "r", "subject_id" => "s", "actions" => { "a" => true} },
         { "resource_id" => "t", "subject_id" => "s", "actions" => { "a" => true} }]
      end
    end

    it "should be initialized with a resource" do
      Policy.new(:resource_id => 'r').should be_a Policy
    end

    context "rules" do
      it "should have rules" do
        c = double('Collection')
        Policy.new(:resource_id => 'r').should respond_to :rules
      end

      it "should find rules" do
        c = double('Collection')
        c.should_receive(:find).with(:resource_id => 'r', :subject_id => 's')
        Policy.new(:resource_id => 'r', :collection => c).rules(:subject_id => 's')
      end
    end

    context  "inserting" do
      let(:coll) { double('Collection') }
      it "should insert rules" do
        coll.should_receive(:update).
          with({ :resource_id => 'r', :subject_id => 's' },
                 {"$set" => { "actions.read" => true }},
                 {:upsert => true})
        policy = Policy.new(:resource_id => 'r', :collection => coll)
        policy.create(:subject_id => 's', :actions => { :read => true })
      end
    end

    context "removing" do
      let(:coll) { double('Collection') }
      it "should remove rule" do
        coll.should_receive(:update).
          with({ :resource_id => 'r', :subject_id => 's' },
                 {"$unset" => { "actions.read" => true }},
                 {:upsert => true})

        policy = Policy.new(:resource_id => 'r', :collection => coll)
        policy.remove(:subject_id => 's', :actions => { :read => true })
      end
    end
  end
end
