require 'spec_helper'

def app
  ApplicationApi
end

describe UsersApi do
  include Rack::Test::Methods

  describe 'e.g. GET, POST, PUT, etc.' do
  	before do
	  	# @user = User.create(username: "test_user_5", password: "password")
	  	# @store = Store.create(name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "DBCRocks!", owner_id: "#{@user.id}")
  	end
  	let(:user_params_1){ {username: "test_user_1", password: "password"} }
  	let(:user_params_2){ {username: "test_user_2", password: "password"} }
  	# let(:store_params){ { name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "DBCRocks!", owner_id: "#{@user.id}" } }
  	# let(:visit_params){{ store_id: "#{@store.id}", customer_id: "#{@user.id}", near_location: true, check_in_code: "DBCRocks!"} }

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
			context 'GET /users/:user_id' do
				it 'returns the user object associated with the user_id' do
					post '/users', user_params_1
					@user = User.find_by_username("test_user_1")
					get "/users/#{@user.id}"
					expect(last_response.status).to eq(200)
					expect(last_response.body.include?("test_user_1")).to eq(true)
				end
			end

			# context 'GET /users/:user_id/visits' do
			# 	it 'returns visits in ascending order from user' do
			# 		post '/users', user_params_1
			# 		post '/visits', visit_params
			# 		@user = User.find_by_username("test_user_1")
			# 		get "/users/#{@user.id}/visits"
			# 		expect(last_response.status).to eq(200)
			# 		p last_response.body
			# 		p @user.visited_stores
			# 		expect(last_response.body)
			# 	end
			# end
  		
  	end


  end

end
