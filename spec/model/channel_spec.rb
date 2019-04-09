require "rails_helper"
require 'channel'

describe Channel do
  context "test fields" do
    before do
      @channel = Channel.create
    end

    subject{ @channel }
    it {should respond_to(:name)}
    
    it "name can not be empty" do
      channel = Channel.new name: ""
      expect(channel).to be_invalid
    end
    
    it "when channel name is taken" do
      channel1 = Channel.create name: "CC"
      expect(channel2 = (Channel.create name: "CC")).to be_invalid
    end

  end
end
