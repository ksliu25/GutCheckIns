require 'spec_helper'

describe Visit, type: :model do



	describe "validations" do

	  	# @new_store = FactoryGirl.create(:store, name: "Starbucks")
	  	# @new_user = FactoryGirl.create(:user, username: "John")
	  	# @new_visit = FactoryGirl.create(:visit, customer_id: @new_user.id, store_id: @new_store.id)
	  	# @stubbed_visit = FactoryGirl.build_stubbed(:visit, customer_id: 1, store_id: 1)

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
		  		@stubbed_store = FactoryGirl.build_stubbed(:store, name:"test_store", daily_code: "test_code")
		  		@invalid_visit = Visit.new(customer_id: 1, store_id: @stubbed_store.id, near_location: true, check_in_code: "not_test_code")
		  		@valid_visit = Visit.new(customer_id: 1, store_id: @stubbed_store.id, near_location: true, check_in_code: "test_code")
		  	end

	  		it "should raise an error for an incorrectly matched code" do
	  			@invalid_visit.valid?
	  			@invalid_visit.save
	  			p Store.find(@invalid_visit.store_id)
	  			p @invalid_visit
	  			p @invalid_visit.store.first.daily_code
	  			p @invalid_visit.check_in_code

	  			expect(@invalid_visit.errors).to include("Does not match daily code!")
	  			# expect(FactoryGirl.create(:visit, customer_id: 1, store_id: @stubbed_store.id, near_location: true, check_in_code: "not_test_code")).to_not be_valid
	  			# @invalid_visit.valid?
	  			# @invalid_visit.save
	  			# expect(@invalid_visit.errors).to include("Does not match daily code!")
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
