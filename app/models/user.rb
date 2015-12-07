class User < ActiveRecord::Base

	validates_presence_of :hashed_password, :username
	validates_uniqueness_of :username

	has_many :stores, foreign_key: "owner_id"
	has_many :visits, foreign_key: "customer_id"

  def self.authenticate(username, password)
    @user = User.find_by_username(username)
    @user if @user && @user.password == password
  end

  def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(new_password)
    # store new_password for use later in validations
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end

end
