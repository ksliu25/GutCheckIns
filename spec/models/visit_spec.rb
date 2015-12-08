require 'spec_helper'

describe Visit, type: :model do

	before do

	end

	describe "validations" do

	  	# @new_store = FactoryGirl.create(:store, name: "Starbucks")
	  	# @new_user = FactoryGirl.create(:user, username: "John")
	  	# @new_visit = FactoryGirl.create(:visit, customer_id: @new_user.id, store_id: @new_store.id)
	  	# @stubbed_visit = FactoryGirl.build_stubbed(:visit, customer_id: 1, store_id: 1)

	  	it { should validate_presence_of(:store_id) }  
	  	it { should validate_presence_of(:customer_id) }  
	  	it { should validate_presence_of(:near_location) }  
	  	it { should validate_presence_of(:check_in_code) } 
	  	it do 
	  		should validate_inclusion_of(:near_location).
	  		in_array([true]).
	  		with_message("visit must be near store location!")
	  	end 	  

	end

  it 'can be created' do
  	user = create(:user, username: "Jimmy")
    visit = create(:visit, customer_id: user.id)
    expect(visit).to_not be_nil
  end

end
