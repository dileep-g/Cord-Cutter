require "rails_helper"
require 'set_top_box'

describe SetTopBox do
  context "test fields" do
    before do
      @set_top_box = SetTopBox.create
    end

    subject{ @set_top_box }
    it {should respond_to(:name)}
    
    it "name can not be empty" do
      set_top_box = SetTopBox.new name: ""
      expect(set_top_box).to be_invalid
    end
    
    it "when box name is taken" do
      set_top_box1 = SetTopBox.create name: "BB"
      expect(set_top_box2 = (SetTopBox.create name: "BB")).to be_invalid
    end

  end
end
