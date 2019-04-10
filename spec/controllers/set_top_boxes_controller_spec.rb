require 'rails_helper'

RSpec.describe SetTopBoxesController, type: :controller do
    before do
        @admin = User.create admin: true, email: "admin@email.com", password: "password"
        session[:user_id] = @admin.id
        @set_top_boxes =[]
        ["Chromecast", "Apple TV", "Fire Stick", "Mi Box"].each do |set_top_box_name|
            @set_top_boxes << SetTopBox.create(name: set_top_box_name).id
        end
    end
    
    describe "#CRUD Operations" do
        it "should get set_top_boxes information" do
            get :index, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end
        
        it "should show set_top_box information" do
            get :show, params: {:id => @set_top_boxes[0]}, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end
        
        it "should create a new set_top_box" do
            post_params = {
                # :set_top_box => {:name => "Maa", :category => "Entertainment"}
                :set_top_box => {:name => "Maa"}
            }
            post :create, params: post_params, session: {:user_id => @admin.id}
            expect(response).to have_http_status(302)
            created_set_top_box = SetTopBox.where(:name => 'Maa').last
            expect(response).to redirect_to set_top_box_path(5) # How to present set_top_box id?
        end

        it "should get the page for creating new set_top_box" do
            get :new, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end
        
        it "should get the page to edit that particular set_top_box" do
            get :edit, params: {:id => @set_top_boxes[0]}, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end

        it "should successfully update the set_top_box with user supplied information" do
            put_params = {
                :id => @set_top_boxes[0],
                :set_top_box => {:name => 1}
            }
            put :update, params: put_params, session: {:user_id => @admin.id}
            expect(response).to have_http_status(302)
            expect(response).to redirect_to "/set_top_boxes/#{@set_top_boxes[0]}"
        end
        
        it "should not successfully update the set_top_box with user supplied information" do
            set_top_box = SetTopBox.create(name: "xyz")
            expect(set_top_box).to receive(:update).and_return(false)
            allow(SetTopBox).to receive(:find).and_return(set_top_box)
            put_params = {
                :id => @set_top_boxes[0],
                # :set_top_box => {:name => 'hbo', :category => 'Entertainment'}
                :set_top_box => {:name => 'hbo'}
            }
            put :update, params: put_params, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
            expect(response).to render_template(:edit)
        end
        
        it "should delete a set_top_box" do
            delete :destroy, params: {:id => @set_top_boxes[0]}, session: {:user_id => @admin.id}
            expect(response).to have_http_status(302)
            expect(response).to redirect_to "/set_top_boxes"
        end
    end
end
