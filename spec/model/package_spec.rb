require "rails_helper"
require 'package'

describe Package do
  context "test fields" do
    before do
      @package = Package.create
    end

    subject{ @package }
    it {should respond_to(:name)}
    
    it "name can not be empty" do
      package = Package.new name: ""
      expect(package).to be_invalid
    end
    
    it "when package name is taken" do
      package1 = Package.create name: "PP"
      expect(package2 = (Package.create name: "PP")).to be_invalid
    end

  end
end
