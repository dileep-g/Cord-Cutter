require "rails_helper"
require 'own_box'

describe OwnBox do
  context "test fields" do
    before do
      @own_box = OwnBox.create
    end

    subject{ @own_box }
    it {should respond_to(:user_id)}
    it {should respond_to(:set_top_box_id)}
    
  end
end
