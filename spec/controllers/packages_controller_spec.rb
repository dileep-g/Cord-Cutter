require 'rails_helper'

RSpec.describe PackagesController, type: :controller do
    before do
        @admin = User.create admin: true, email: "admin@email.com", password: "password"
        session[:user_id] = @admin.id
        @packages = []
        ["HBO Prime", "Youtube Prime", "Hulu Prime"].each do |package_name|
            @packages << Package.create(name: package_name).id
        end
    end
    
    describe "#CRUD Operations" do
        it "should get packages information" do
            get :index, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end
        
        it "should show packages information" do
            get :show, params: {:id => @packages[0]}, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end
        
        it "should create a new package" do
            post_params = {
                # :channel => {:name => "Maa", :category => "Entertainment"}
                :package => {:name => "Maa"}
            }
            post :create, params: post_params, session: {:user_id => @admin.id}
            expect(response).to have_http_status(302)
            created_package = Package.where(:name => 'Maa').last
            expect(response).to redirect_to package_path(4) # How to present channel id?
        end

        it "should get the page for creating new package" do
            get :new, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end
        
        it "should get the page to edit that particular package" do
            get :edit, params: {:id => @packages[0]}, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
        end

        it "should successfully update the channel with user supplied information" do
            put_params = {
                :id => @packages[0],
                :package => {:name => 1}
            }
            put :update, params: put_params, session: {:user_id => @admin.id}
            expect(response).to have_http_status(302)
            expect(response).to redirect_to "/packages/#{@packages[0]}"
        end
        
        it "should not successfully update the channel with user supplied information" do
            package = Package.create(name: "xyz")
            expect(package).to receive(:update).and_return(false)
            allow(Package).to receive(:find).and_return(package)
            put_params = {
                :id => @packages[0],
                # :channel => {:name => 'hbo', :category => 'Entertainment'}
                :package => {:name => 'hbo'}
            }
            put :update, params: put_params, session: {:user_id => @admin.id}
            expect(response).to have_http_status(200)
            expect(response).to render_template(:edit)
        end
        
        it "should delete a package" do
            delete :destroy, params: {:id => @packages[0]}, session: {:user_id => @admin.id}
            expect(response).to have_http_status(302)
            expect(response).to redirect_to "/packages"
        end
    end
end
