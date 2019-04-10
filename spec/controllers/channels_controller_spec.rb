require 'rails_helper'

RSpec.describe ChannelsController, type: :controller do
    # describe "not an admin"do
    #     before do
    #         @user = User.create admin: false, email: "user@email.com", password: "password"
    #         session[:user_id] = @user.id
    #     end
    #     it "should not access channels" do
    #         expect(response).to redirect_to root_path
    #     end
    # end
    
    before do
        @admin = User.create admin: true, email: "admin@email.com", password: "password"
        session[:user_id] = @admin.id
        @channels = []
        ["hbo", "star", "abc", "news"].each do |channel_name|
         @channels << Channel.create(name: channel_name).id
        end
    end
    
    describe "#CRUD Operations" do
        it "should get channels information" do
            get :index, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end
        
        it "should show channel information" do
            get :show, params: {:id => @channels[0]}, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end
        
        it "should create a new channel" do
            post_params = {
                # :channel => {:name => "Maa", :category => "Entertainment"}
                :channel => {:name => "Maa"}
            }
            post :create, params: post_params, session: {:user_id => @admin.id}
            expect(response).to have_http_status(302)
            created_channel = Channel.where(:name => 'Maa').last
            expect(response).to redirect_to channel_path(5) # How to present channel id?
        end

        it "should get the page for creating new channel" do
            get :new, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end
        
        it "should get the page to edit that particular channel" do
            get :edit, params: {:id => @channels[0]}, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end

        it "should successfully update the channel with user supplied information" do
            put_params = {
                :id => @channels[0],
                :channel => {:name => 1}
            }
            put :update, params: put_params, session: {:user_id => @admin.id}
            expect(response).to have_http_status(302)
            expect(response).to redirect_to "/channels/#{@channels[0]}"
        end
        
        it "should not successfully update the channel with user supplied information" do
            channel = Channel.create(name: "xyz")
            expect(channel).to receive(:update).and_return(false)
            allow(Channel).to receive(:find).and_return(channel)
            put_params = {
                :id => @channels[0],
                # :channel => {:name => 'hbo', :category => 'Entertainment'}
                :channel => {:name => 'hbo'}
            }
            put :update, params: put_params, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
            expect(response).to render_template(:edit)
        end
        
        it "should delete a channel" do
            delete :destroy, params: {:id => @channels[0]}, session: {:user_id => @admin.id}
            expect(response).to have_http_status(302)
            expect(response).to redirect_to "/channels"
        end
    end
end
