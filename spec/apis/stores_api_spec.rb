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
  			expect(last_response.body.include?("DBC Burgers")).to eq(true)
  		end
  	end

  	context "GET /stores" do
  		it "returns all stores" do
  			get '/stores'
  			expect(last_response.status).to eq(200)
  			expect(last_response.body.include?("DBC Burgers")).to eq(true)
  		end
  	end

    describe "single store actions" do
    	context "GET /stores/:id" do
    		it "returns the given store" do
    			get "/stores/#{@store.id}"
    			expect(last_response.status).to eq(200)
    			expect(last_response.body.include?("DBC Burgers")).to eq(true)
    		end
    	end

      context "GET /stores/:id/visits" do
        it 'returns visits in ascending order from user' do
          post '/visits', {store_id: "#{@store.id}", customer_id: "#{@user.id}", near_location: true, check_in_code: "DBCRocks!"}
          get "/stores/#{@store.id}/visits"
          expect(last_response.status).to eq(200)
          expect(last_response.body.include?("DBCRocks!")).to eq(true)
        end
      end

      context "GET /stores/:id/customers" do
        it 'returns visits in ascending order from user' do
          post '/visits', {store_id: "#{@store.id}", customer_id: "#{@user.id}", near_location: true, check_in_code: "DBCRocks!"}
          get "/stores/#{@store.id}/customers"
          expect(last_response.status).to eq(200)
          expect(last_response.body.include?("test_user_4")).to eq(true)
        end
      end

      context "GET /stores/:id/metrics" do
        it 'returns visits in ascending order from user' do
          post '/visits', {store_id: "#{@store.id}", customer_id: "#{@user.id}", near_location: true, check_in_code: "DBCRocks!"}
          get "/stores/#{@store.id}/metrics"
          expect(last_response.status).to eq(200)
          expect(last_response.body.include?("test_user_4")).to eq(true)
          expect(last_response.body.include?("1")).to eq(true)

        end
      end
    end

  end

end
