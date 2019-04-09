require "rails_helper"
require 'perference'
require 'user'
require 'channel'

describe Perference do
  context "test fields" do
    before do
      @perference = Perference.create
      user = User.create email: "abc@123.com", password: "987654"
      channel = Channel.create name: "CC"
    end

    subject{ @perference }
    it {should respond_to(:user_id)}
    it {should respond_to(:channel_id)}
    it {should respond_to(:rate)}

    it "perference rate should be valid" do
      expect(perfer1 = Perference.create(user_id: 1, channel_id: 1, rate: 1)).to be_valid
      #expect(perfer2 = Perference.create(user_id: 1, channel_id: 1, rate: 1.1)).to be_invalid
      expect(perfer3 = Perference.create(user_id: 1, channel_id: 1, rate: -1)).to be_invalid
      expect(perfer4 = Perference.create(user_id: 1, channel_id: 1, rate: 4)).to be_invalid
    end

  end
end
