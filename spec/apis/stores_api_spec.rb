require 'spec_helper'

def app
  ApplicationApi
end

describe StoresApi do
  include Rack::Test::Methods

  describe 'e.g. GET, POST, PUT, etc.' do
  	context "POST /stores" do
  		it "can create a store given a user" do
  			@user = User.create(username: "test_user_4", password: "password")
  			params = {name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "DBCRocks!", owner_id: "#{@user.id}" }
  			post '/stores', params
  			expect(last_response.status).to eq(201)
  			expect(JSON.parse(last_response.body)).to eq("data" => {"object_type"=>"store", "id"=>"1", "name"=>"DBC Burgers", "daily_code"=>"DBCRocks!", "owner_id"=>1} )
  		end
  	end

  	context "GET /stores" do
  		it "returns all stores" do
  			
  		# 	User.create(username: "test_user_5", password: "password")
  		# 	p User.all
  		# 	params = {}
  		# 	get '/stores'
  		# 	response.body.should == ""
  		end
  	end

  # 	end
  #   it 'needs tests to be written!' do
  #     pending('write tests for StoresApi!')
  #   end
  end

end
