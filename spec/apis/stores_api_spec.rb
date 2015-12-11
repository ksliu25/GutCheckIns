require 'spec_helper'

def app
  ApplicationApi
end

describe StoresApi do
  include Rack::Test::Methods

  describe 'e.g. GET, POST, PUT, etc.' do
  	before do
  		@user = User.create(username: "test_user_4", password: "password")
  		@store = Store.create(name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "DBCRocks!", owner_id: "#{@user.id}")
  	end
  	let(:params_store){{name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "DBCRocks!", owner_id: "#{@user.id}" } }

  	context "POST /stores" do
  		it "can create a store given a user" do
  			post '/stores', params_store
  			expect(last_response.status).to eq(201)
  			expect(JSON.parse(last_response.body)).to eq("data" => {"object_type"=>"store", "id"=>"2", "name"=>"DBC Burgers", "daily_code"=>"DBCRocks!", "owner_id"=>1} )
  		end
  	end

  	context "GET /stores" do
  		it "returns all stores" do
  			get '/stores'
  			expect(last_response.status).to eq(200)
  			expect(JSON.parse(last_response.body)).to eq("data" => [{"object_type"=>"store", "id"=>"3", "name"=>"DBC Burgers", "daily_code"=>"DBCRocks!", "owner_id"=>2}] )
  		end
  	end

  	context "GET /stores/:id" do
  		it "returns the given store" do
  			get "/stores/#{@store.id}"
  			expect(last_response.status).to eq(200)
  			expect(JSON.parse(last_response.body)).to eq("data" => {"object_type"=>"store", "id"=>"#{@store.id}", "name"=>"#{@store.name}", "daily_code"=>"#{@store.daily_code}", "owner_id"=>"#{@store.owner_id}".to_i})
  		end
  	end

  # 	end
  #   it 'needs tests to be written!' do
  #     pending('write tests for StoresApi!')
  #   end
  end

end
