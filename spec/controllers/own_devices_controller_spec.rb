require 'rails_helper'

RSpec.describe OwnDevicesController, type: :controller do
    before do
        @admin = User.create admin: true, email: "admin@email.com", password: "password"
        session[:user_id] = @admin.id
        @devices = []
        ["iOS", "Andriod", "Computer"].each do |device_name|
            @devices << Device.create(name: device_name).id
        end
    end
    
    it 'should render devices page' do
        get :show, params: { id: session[:user_id] }
        expect(response).to have_http_status(200)
    end
end
