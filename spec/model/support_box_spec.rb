require "rails_helper"
require 'support_box'

describe SupportBox do
  context "test fields" do
    before do
      @support_box = SupportBox.create
    end

    subject{ @support_box }
    it {should respond_to(:package_id)}
    it {should respond_to(:set_top_box_id)}

  end
end
