require 'spec_helper'

module Permit
  describe Config do
    let(:subject) do
      Config.new
    end

    it "should be initialied when calling Permit.config" do
      Permit.config.should be_a Config
    end
  end
end
