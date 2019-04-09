require "rails_helper"
require 'antenna'

describe Antenna do
  context "test fields" do
    before do
      @antenna = Antenna.create
    end

    subject{ @antenna }
    it {should respond_to(:user_id)}
    it {should respond_to(:channel_id)}

  end
end
