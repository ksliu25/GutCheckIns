require 'spec_helper'

describe Visit, type: :model do

	describe "validations" do

	  	it { should validate_presence_of(:store_id) }  
	  	it { should validate_presence_of(:customer_id) }  
	  	it { should validate_presence_of(:near_location) }  
	  	it { should validate_presence_of(:check_in_code) } 

	  	it { should belong_to(:customer)}
	  	it { should belong_to(:store)}

	  	it do 
	  		should validate_inclusion_of(:near_location).
	  		in_array([true]).
	  		with_message("visit must be near store location!")
	  	end

	  	describe "match_daily_code" do
	  		before(:each) do
	  			@user = User.create(username: "test_user", password: "password")
		  		@store = Store.create(name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "test_code", owner: @user)
		  		@invalid_visit = Visit.new(customer: @user, store: @store, near_location: true, check_in_code: "not_test_code")
		  		@valid_visit = Visit.new(customer_id: @user, store_id: @store, near_location: true, check_in_code: "test_code")
		  	end

	  		it "should raise an error for an incorrectly matched code" do
	  			@invalid_visit.valid?
	  			@invalid_visit.save

	  			expect(@invalid_visit.errors).to include("Does not match daily code!")
	  		end

	  		it "should save correctly for a correctly matched code" do
	  			@valid_visit.valid?
	  			expect(@valid_visit.errors).to_not include("Does not match daily code!")
	  		end

	  	end


	end

  it 'can be created' do
  	user = create(:user, username: "Jimmy")
    visit = create(:visit, customer_id: user.id)
    expect(visit).to_not be_nil
  end

end
