require 'spec_helper'

def app
  ApplicationApi
end

describe UsersApi do
  include Rack::Test::Methods

  describe 'e.g. GET, POST, PUT, etc.' do
  	before do

  	end
  	let(:user_params_1){ {username: "test_user_1", password: "password"} }
  	let(:user_params_2){ {username: "test_user_2", password: "password"} }
  	let(:store_params){ {name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "DBCRocks!", owner_id: "#{@user.id}" } }
  	let(:visit_params){ }

  	context 'POST /users' do
			it 'can create a single user' do
				post '/users', user_params_1
				expect(last_response.status).to eq(201)
				expect(JSON.parse(last_response.body)).to eq({"data" => { "object_type" => "user", "id" => "4", "username" => "test_user_1" }})
			end
  	end

  	context 'GET /users' do
  		it 'returns an array of users' do
  			post '/users', user_params_1
  			post '/users', user_params_2
	  		get '/users'
	  		expect(last_response.status).to eq(200)
	  		expect(JSON.parse(last_response.body)).to eq({"data" => [{ "object_type" => "user", "id" => "5", "username" => "test_user_1" }, { "object_type" => "user", "id" => "6", "username" => "test_user_2" }]})
  		end

  	end

  	describe 'single user actions' do
			context 'GET /users/:user_id' do
				it 'returns the userobject associated with the user_id' do
					post '/users', user_params_1
					@user = User.find_by_username("test_user_1")
					get "/users/#{@user.id}"
					expect(last_response.status).to eq(200)
					expect(JSON.parse(last_response.body)).to eq({"data" => { "object_type" => "user", "id" => "#{@user.id}", "username" => "test_user_1" }})
				end
			end

			context 'GET /users/:user_id/visits' do
				# it 'returns visits in ascending order from user' do
				# 	post '/users', user_params_1
				# 	@user = User.find_by_username("test_user_1")
				# 	get "/users/#{@user.id}/"
				# end
			end
  		
  	end


  end

end
