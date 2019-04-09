require "rails_helper"
require 'user'

describe User do
  context "test fields" do
    before do
      @user = User.create
    end

    subject{ @user }
    it {should respond_to(:email)}
    it {should respond_to(:password)}
    it {should respond_to(:first_name)}
    it {should respond_to(:last_name)}

    it "when email is valid" do
      user1 = User.create email: "abc@edf.com", password: "123456"
      expect(user1).to be_valid
    end
    it "when email does not have @" do
      user1 = User.create email: "abcdef.com", password: "123456"
      expect(user1).to be_invalid
    end
    it "when email dose not have ." do
      user1 = User.new email: "abc@edfcom", password: "123456"
      expect(user1).to be_invalid
    end
    it "when email is taken" do
      user1 = User.create email: "abc@def.com", password: "123456"
      expect(user2 = (User.create email: "abc@Def.com", password: "234567")).to be_invalid
    end
    it "when password is valid" do
      user1 = User.new email: "abc@edf.com", password: "123456"
      expect(user1).to be_valid
    end
    it "when password is too short" do
      user1 = User.new email: "abc@edf.com", password: "12345"
      expect(user1).to be_invalid
    end

  end
end
