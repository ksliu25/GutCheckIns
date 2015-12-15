require 'spec_helper'

def app
  ApplicationApi
end

describe VisitsApi do
  include Rack::Test::Methods

  describe 'e.g. GET, POST, PUT, etc.' do
  	before do
  		@user = User.create(username: "test_user_4", password: "password")
  		@store = Store.create(name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "DBCRocks!", owner_id: "#{@user.id}")
  	end
  	let(:valid_visit_params){{store_id: "#{@store.id}", customer_id: "#{@user.id}", near_location: true, check_in_code: "DBCRocks!"}}
  	let(:invalid_location_visit_params){{store_id: "#{@store.id}", customer_id: "#{@user.id}", near_location: false, check_in_code: "DBCRocks!"}}
  	let(:invalid_code_visit_params){{store_id: "#{@store.id}", customer_id: "#{@user.id}", near_location: true, check_in_code: "INCORRECT"}}

  	context 'post /visits' do
  		it "can create a new visit with all the right validations" do
        basic_authorize(@user.username, @user.password)
  			post '/visits', valid_visit_params
  			expect(last_response.status).to eq(201)
  			expect(last_response.body.include?("DBCRocks!")).to eq(true)
  		end

  		it "will return an error if the client-side validations fail for near_location" do
  			post '/visits', invalid_location_visit_params
  			expect(last_response.status).to eq(422)
        expect(last_response.body.include?("visit must be near store location!"))
  		end

  		it "will return an error for an invalid code" do
  			post '/visits', invalid_code_visit_params
  			expect(last_response.status).to eq(422)
        expect(last_response.body.include?("Does not match daily code!"))
  		end

  	end
  end

end
