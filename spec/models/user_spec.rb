require 'spec_helper'

describe User, type: :model do
 
  describe "basic validations" do
    it { should validate_presence_of(:hashed_password) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }

    context "associations" do
      it { should have_many(:visits) }
      it { should have_many(:stores) }
      it { should have_many(:visited_stores) }
    end

  end

  describe "authenticate" do
    let(:new_user){FactoryGirl.create(:user)}
    it "returns a user when provided with valid credentials" do
      expect(User.authenticate(new_user.username, "password")).to eq(new_user)
    end

    it "returns nil when provided with invalid credentials" do
      expect(User.authenticate(new_user.username, "NOTpassword")).to eq(nil)
    end

  end

  describe "helper methods" do
    before(:each) do
      @user = User.create(username: "test_user", password: "password")
      @store = Store.create(name: "DBC Burgers", address: "351 W Hubbard St, Chicago, IL 60654, USA", latitude: 41.8897170, longitude: -87.6376110, daily_code: "test_code", owner: @user)
      @test_visit = Visit.new(customer: @user, store: @store, near_location: true, check_in_code: "test_code")

    end

    context "#array_of_stores" do
      it "returns an array of stores that have been visited" do
        @test_visit.save
        expect(@user.array_of_stores).to eq(["DBC Burgers"])
      end
    end

    context "#num_of_visits_at" do
      it "returns the number of check ins when given a store name" do
        @test_visit.save
        expect(@user.num_of_visits_at(@store.name)).to eq(1)
      end
    end
    
  end


  it 'can be created' do
    user = create :user
    expect(user).to_not be_nil
  end

end
