require 'spec_helper'

describe Visit, type: :model do

	describe "validations" do
		# let(:new_user){ User.create(username: "Kenneth", password: "password")}
		# let(:new_store){Store.create(name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "DBCRocks!", owner_id: 1)}
		# let(:new_visit){Visit.create(store_id: new_store.id, customer_id: new_customer.id, near_location: true, check_in_code: "DBCRocks!" )}
		let(:new_visit){ FactoryGirl.create(:valid_visit) }

	  describe "validations" do

	  	it { should validate_presence_of(:store_id) }  
	  	it { should validate_presence_of(:customer_id) }  
	  	it { should validate_presence_of(:near_location) }  
	  	it { should validate_presence_of(:check_in_code) }  	  
	  end

	end

  it 'can be created' do
    visit = create :valid_visit
    expect(visit).to_not be_nil
  end

  it 'needs tests to be written!' do
    pending('write tests for Visit!')
  end

end
