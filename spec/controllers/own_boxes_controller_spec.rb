require 'rails_helper'

RSpec.describe OwnBoxesController, type: :controller do
    before do
        @admin = User.create admin: true, email: "admin@email.com", password: "password"
        session[:user_id] = @admin.id
        @set_top_boxes =[]
        ["Chromecast", "Apple TV", "Fire Stick", "Mi Box"].each do |set_top_box_name|
            @set_top_boxes << SetTopBox.create(name: set_top_box_name).id
        end
    end
    
    it 'should render devices page' do
        get :show, params: { id: session[:user_id] }
        expect(response).to have_http_status(200)
    end
end
