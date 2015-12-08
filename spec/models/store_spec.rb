require 'spec_helper'

describe Store, type: :model do


  it 'can be created' do
    store = create :store
    expect(store).to_not be_nil
  end

	# let(:new_store){Store.create(name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "DBCRocks!", owner_id: 1)}
	let(:new_store){FactoryGirl.create(:store)}

  describe "validations" do

  	it { should validate_presence_of(:name) }  
  	it { should validate_presence_of(:address) }  
  	it { should validate_presence_of(:latitude) }  
  	it { should validate_presence_of(:longitude) }  	  
  	it { should validate_presence_of(:owner_id) }

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

end
