require 'spec_helper'

describe User, type: :model do
  let(:new_user){ User.new(username: "Kenneth", password: "password")}
 
  describe "validations" do
    it {should validate_presence_of(:hashed_password)}
    it {should validate_presence_of(:username)}

    describe "validates uniqueness of username" do
      before{User.new(username: "Not Kenneth", password: "password")}
      it {should validate_uniqueness_of(:username)}

    end
  end

  it 'can be created' do
    user = create :user
    expect(user).to_not be_nil
  end

end
