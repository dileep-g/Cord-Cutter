require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "signup" do
        it 'should create a user successfully' do
            post :create, :params => {:user => {:email => 'user@email.com', :password => 'password'}}
            expect(response).to redirect_to user_path(1)
        end
        
        it 'should create a user unsuccessfully' do
            post :create, :params => {:user => {:email => nil, :password => nil}}
            expect(response).to render_template :new
        end
    end 
    
    describe "user CRUD" do
    
        before :each do
            @user = User.create email: "user@email.com", password: "password"
            session[:user_id] = @user.id
        end

        describe "#show" do
            before do
                @channels = []
                ["ESPN Sports", "HBO Drama", "NBC News"].each do |channel_name|
                    @channels << Channel.create(name: channel_name).id
                end
                @devices = []
                ["iOS", "Andriod", "Computer"].each do |device_name|
                    @devices << Device.create(name: device_name).id
                end
                @set_top_boxes =[]
                ["Chromecast", "Apple TV", "Fire Stick", "Mi Box"].each do |set_top_box_name|
                    @set_top_boxes << SetTopBox.create(name: set_top_box_name).id
                end
            end
            it 'should render user profile page' do
            get :show, params: { id: session[:user_id] }
            expect(response).to have_http_status(200)
            end           
        end
        
        describe "#edit" do
            it 'should render the edit in views/users' do
                get :edit, params: { id: session[:user_id] }
                expect(response).to render_template :edit
            end           
        end
        
        describe "#update" do
            let(:new_attributes) {
                { first_name: "user", last_name: "fake", email: "new_user@email.com" }}
                # { first_name: "user", last_name: "fake", email: "new_user@email.com" }} # Currently not support update
            it 'should render show if information updated successfully' do
                put :update, params: {:id => @user.to_param, :user => new_attributes}
                @user.reload
                expect(@user.first_name).to eq_to("user")
                expect(@user.last_name).to eq_to("fake")
                expect(response).to redirect_to user_path(session[:user_id])
            end           
        end
        
        describe "#destroy" do
            it "should delete the user" do
                expect{ 
                    delete :destroy, params:{:id => @user, :user => {:password => @user.password}}
                }.to change(User, :count).by(-1)
            end
            
            # it "should not delete the admin" do
            #     @admin = User.create admin: true, email: "admin@email.com", password: "password"
            #     delete :destroy, params:{:id => @admin, :user => {:password => @admin.password}}
            #     expect(response).to redirect_to users_path
            # end
        end
    end
    
end
