require 'spec_helper'

describe User do
	# let(:new_user){ User.create(username: "Kenneth", password: "password")}

	# describe "validations" do
	# 	it {should validate_presence_of(:name)}
	# 	it {should validate_presence_of(:hashed_password)}

	# end	

  it 'can be created' do
    user = create :user
    expect(user).to_not be_nil
  end

  it 'needs tests to be written!' do
    pending('write tests for User!')
  end

end
