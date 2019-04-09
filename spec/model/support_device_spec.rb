require "rails_helper"
require 'support_device'

describe SupportDevice do
  context "test fields" do
    before do
      @support_device = SupportDevice.create
    end

    subject{ @support_device }
    it {should respond_to(:package_id)}
    it {should respond_to(:device_id)}

  end
end
