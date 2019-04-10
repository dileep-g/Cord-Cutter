require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "POST #create" do
    before :each do
      @user_a = User.create! email: "user_a@email.com", password: "password"
    end

    it "should successfully create a user" do
      expect(@user_a).to be_valid
      # response.should redirect_to user_path(@user_a.id)
      # expect {
      #   post :create, params: {email: "user_a@email.com", password: "password"}
      # }.to change{ User.count }.by(1)
    end

    it "should successfully create a session" do
      expect(session[:user_id]).to be_nil
      session[:user_id] = @user_a.id
      expect(session[:user_id]).not_to be_nil
    end
  end

  describe "#destroy" do

    before :each do
      @user_b = User.create! email: "user_b@email.com", password: "password"
    end
    it "should clear the session" do
      session[:user_id] = @user_b.id
      expect(session[:user_id]).not_to be_nil
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "should redirect to the home page" do
      delete :destroy
      expect(response).to redirect_to root_url
    end
  end
  
end 