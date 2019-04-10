require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
    before do
        @admin = User.create admin: true, email: "admin@email.com", password: "password"
        session[:user_id] = @admin.id
        @devices = []
        ["iOS", "Andriod", "Computer"].each do |device_name|
            @devices << Device.create(name: device_name).id
        end
    end
    
    describe "#CRUD Operations" do
        it "should get devices information" do
            get :index, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end
        
        it "should show devices information" do
            get :show, params: {:id => @devices[0]}, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end
        
        it "should create a new device" do
            post_params = {
                # :channel => {:name => "Maa", :category => "Entertainment"}
                :device => {:name => "Maa"}
            }
            post :create, params: post_params, session: {:user_id => @admin.id}
            expect(response).to have_http_status(302)
            created_device = Device.where(:name => 'Maa').last
            expect(response).to redirect_to device_path(4) # How to present channel id?
        end

        it "should get the page for creating new device" do
            get :new, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end
        
        it "should get the page to edit that particular device" do
            get :edit, params: {:id => @devices[0]}, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end

        it "should successfully update the channel with user supplied information" do
            put_params = {
                :id => @devices[0],
                :device => {:name => 1}
            }
            put :update, params: put_params, session: {:user_id => @admin.id}
            expect(response).to have_http_status(302)
            expect(response).to redirect_to "/devices/#{@devices[0]}"
        end
        
        it "should not successfully update the channel with user supplied information" do
            device = Device.create(name: "xyz")
            expect(device).to receive(:update).and_return(false)
            allow(Device).to receive(:find).and_return(device)
            put_params = {
                :id => @devices[0],
                # :channel => {:name => 'hbo', :category => 'Entertainment'}
                :device => {:name => 'hbo'}
            }
            put :update, params: put_params, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
            expect(response).to render_template(:edit)
        end
        
        it "should delete a device" do
            delete :destroy, params: {:id => @devices[0]}, session: {:user_id => @admin.id}
            expect(response).to have_http_status(302)
            expect(response).to redirect_to "/devices"
        end
    end
end
