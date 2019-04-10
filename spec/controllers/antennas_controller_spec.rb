require 'rails_helper'

RSpec.describe AntennasController, type: :controller do
    before :each do
        @user = User.create email: "user@email.com", password: "password"
        session[:user_id] = @user.id
        @channels = []
        ["ESPN Sports", "HBO Drama", "NBC News"].each do |channel_name|
            @channels << Channel.create(name: channel_name).id
        end
    end
    
    it 'should render antennas page' do
        get :show, params: { id: session[:user_id] }
        expect(response).to have_http_status(200)
    end
    
    describe "#update_antenna" do
        # let(:new_attributes) {
        #     { first_name: "user", last_name: "fake", email: "new_user@email.com" }}
        #     # { first_name: "user", last_name: "fake", email: "new_user@email.com" }} # Currently not support update
        # it 'should render show if information updated successfully' do
        #     put :update, params: {:id => @user.to_param, :user => new_attributes}
        #     @user.reload
        #     expect(@user.first_name).to eq_to("user")
        #     expect(@user.last_name).to eq_to("fake")
        #     expect(response).to redirect_to user_path(session[:user_id])
        # end   
    end

end
