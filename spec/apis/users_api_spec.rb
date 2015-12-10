require 'spec_helper'

def app
  ApplicationApi
end

describe UsersApi do
  include Rack::Test::Methods

  describe 'e.g. GET, POST, PUT, etc.' do
  	before do

  	end

  	context 'POST /users' do
			it 'can create a single user' do
				params = {username: "Kenneth", password: "password"}
				post '/users', params
				expect(last_response.status).to eq(201)
				expect(JSON.parse(last_response.body)).to eq({"data" => {"object_type" => "user", "id" => "1", "username" => "Kenneth"}})
			end
  	end

  	context 'GET /users' do
  		it 'returns an empty array of users' do
  			params = {username: "Kenneth", password: "password"}
  			post '/users', params
	  		get '/users'
	  		expect(last_response.status).to eq(200)
	  		expect(JSON.parse(last_response.body)).to eq({"data" => [{"object_type" => "user", "id" => "2", "username" => "Kenneth"}]})
  		end
  	end


    # it 'needs tests to be written!' do
    #   pending('write tests for UsersApi!')
    # end
  end

end
