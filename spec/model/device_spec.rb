require "rails_helper"
require 'device'

describe Device do
  context "test fields" do
    before do
      @device = Device.create
    end

    subject{ @device }
    it {should respond_to(:name)}
    
    it "name can not be empty" do
      device = Device.new name: ""
      expect(device).to be_invalid
    end
    
    it "when device name is taken" do
      device1 = Device.create name: "DD"
      expect(device2 = (Device.create name: "DD")).to be_invalid
    end

  end
end
