require 'spec_helper'

describe Store, type: :model do


  it 'can be created' do
    store = create :store
    expect(store).to_not be_nil
  end

  describe "validations" do

  	it { should validate_presence_of(:name) }  
  	it { should validate_presence_of(:address) }  
  	it { should validate_presence_of(:latitude) }  
  	it { should validate_presence_of(:longitude) }  	  
  	it { should validate_presence_of(:owner_id) }

    context "associations" do
    	it { should belong_to(:owner) }
      it { should have_many(:customers) }
    end

  	it "should generate a new daily if nothing is given" do
  		store = Store.new(name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, owner_id: 1)
  		store.valid?
  		store.daily_code != nil
  	end

  	it "should generate a new daily code to whatever is given" do
  		store = Store.new(name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "DBCRocks!", owner_id: 1)
  		store.valid?
  		store.daily_code == "DBCRocks!"
  	end
  	
  end
  describe "helper methods" do
    before(:each) do
      @user = User.create(username: "test_user", password: "password")
      @store = Store.create(name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "test_code", owner: @user)
      @test_visit = Visit.new(customer: @user, store: @store, near_location: true, check_in_code: "test_code")
    end

    context "#customer_breakdown" do
      it "returns a hash of customers and number of visits" do
        @test_visit.save 
        expect(@store.customer_breakdown).to eq({"test_user" => 1})
      end
    end

    context "#array_of_customers" do
      it "returns an array of customers by username" do
        @test_visit.save
        expect(@store.array_of_customers).to eq(["test_user"])
      end
    end

    context "#num_of_visits_from" do
      it "returns the number of check ins when given a store name" do
        @test_visit.save
        expect(@store.num_of_visits_from(@user.username)).to eq(1)
      end
    end
    
  end


end
