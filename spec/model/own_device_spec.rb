require "rails_helper"
require 'own_device'

describe OwnDevice do
  context "test fields" do
    before do
      @own_device = OwnDevice.create
    end

    subject{ @own_device }
    it {should respond_to(:user_id)}
    it {should respond_to(:device_id)}

  end
end
