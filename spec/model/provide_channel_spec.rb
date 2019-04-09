require "rails_helper"
require 'provide_channel'

describe ProvideChannel do
  context "test fields" do
    before do
      @provide_channel = ProvideChannel.create
    end

    subject{ @provide_channel }
    it {should respond_to(:package_id)}
    it {should respond_to(:channel_id)}

  end
end
