class User < ActiveRecord::Base

	validate :password_requirements
	
	has_many :stores, foreign_key: "owner_id"
	has_many :visits, foreign_key: "customer_id"

	def self.authenticate(username, password)
	  @user = User.find_by(username)
	  @user if @user && @user.password == password
	end

  def password
    @password ||= BCrypt::Password.new(hashed_password)
  end
​
  def password=(new_password)
    # store the new_password for use later in validations
    @raw_password = new_password
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end
​
  private
​
  # a reader for the raw password
  # private because we don't want people to try to
  # us the field outside of this class
  def raw_password
    @raw_password
  end
​
  def password_requirements
    # only run validations if raw_password is set (not nil)
    # OR if the record hasn't been saved yet (we require a
    # password to create a user)
    if raw_password || new_record?
​
      # validate that the raw password is at least 6 characters long
      # and contains 1 special character (!@#$%^&*)
      if raw_password.length < 6 || !(raw_password =~ /[!@#$%^&*]/)
        errors.add(:password, "must be at least 6 characters long and contain at least 1 special character (!@#$%^&*).")
      end
    end
  end

end
