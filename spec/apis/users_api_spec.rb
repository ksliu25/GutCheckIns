require 'spec_helper'

def app
  ApplicationApi
end

describe UsersApi do
  include Rack::Test::Methods

  describe 'e.g. GET, POST, PUT, etc.' do
  	let(:user_params_1){ {username: "test_user_1", password: "password"} }
  	let(:user_params_2){ {username: "test_user_2", password: "password"} }

  	context 'POST /users' do
			it 'can create a single user' do
				post '/users', user_params_1
				expect(last_response.status).to eq(201)
				expect(last_response.body.include?('test_user_1')).to eq(true)
			end
  	end

  	context 'GET /users' do
  		it 'returns an array of users' do
  			post '/users', user_params_1
  			post '/users', user_params_2
	  		get '/users'
	  		expect(last_response.status).to eq(200)
	  		expect(last_response.body.include?('test_user_1')).to eq(true)
	  		expect(last_response.body.include?('test_user_2')).to eq(true)
  		end

  	end

  	describe 'single user actions' do
			context 'GET /users/:id' do
				it 'returns the user object associated with the id' do
					post '/users', user_params_1
					@user = User.find_by_username("test_user_1")
					get "/users/#{@user.id}"
					expect(last_response.status).to eq(200)
					expect(last_response.body.include?("test_user_1")).to eq(true)
				end
			end

			before do
				post '/users', user_params_1
				@user = User.find_by_username("test_user_1")
				post '/stores', {name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "DBCRocks!", owner_id: "#{@user.id}" } 
				@store = Store.find_by_name("DBC Burgers")
			end
			context 'GET /users/:id/visits' do
				it 'returns visits in ascending order from user' do
					post '/visits', {store_id: "#{@store.id}", customer_id: "#{@user.id}", near_location: true, check_in_code: "DBCRocks!"}
					get "/users/#{@user.id}/visits"
					expect(last_response.status).to eq(200)
					expect(last_response.body.include?("DBCRocks!")).to eq(true)
				end
			end
			context 'GET /users/:id/stores' do
				it 'returns all stores visited' do
					post '/visits', {store_id: "#{@store.id}", customer_id: "#{@user.id}", near_location: true, check_in_code: "DBCRocks!"}
					get "/users/#{@user.id}/stores"
					expect(last_response.status).to eq(200)
					expect(last_response.body.include?("DBC Burgers")).to eq(true)
				end
			end
			context 'GET /users/:id/metrics' do
				it 'returns metrics involving stores and number of visits' do
					post '/visits', {store_id: "#{@store.id}", customer_id: "#{@user.id}", near_location: true, check_in_code: "DBCRocks!"}
					get "/users/#{@user.id}/metrics"
					expect(last_response.status).to eq(200)
					expect(last_response.body.include?("DBC Burgers")).to eq(true)
					expect(last_response.body.include?("1")).to eq(true)
				end
			end
  		
  	end


  end

end
