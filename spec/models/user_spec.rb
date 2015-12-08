require 'spec_helper'

describe User, type: :model do
  # let(:new_user){ User.create(username: "Kenneth", password: "password")}
  let(:new_user){FactoryGirl.create(:user)}
 
  describe "basic validations" do
    it {should validate_presence_of(:hashed_password)}
    it {should validate_presence_of(:username)}

  end

  describe "authenticate" do
    it "returns a user when provided with valid credentials" do
      expect(User.authenticate(new_user.username, "password")).to eq(new_user)
    end

    it "returns nil when provided with invalid credentials" do
      expect(User.authenticate(new_user.username, "NOTpassword")).to eq(nil)
    end

  end

  it 'can be created' do
    user = create :user
    expect(user).to_not be_nil
  end

end
