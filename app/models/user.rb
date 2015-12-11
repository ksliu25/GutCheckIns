class User < ActiveRecord::Base

	validates_presence_of :hashed_password, :username
	validates_uniqueness_of :username

	has_many :stores, foreign_key: "owner_id"
	has_many :visits, foreign_key: "customer_id"
  has_many :visited_stores, through: :visits, source: :store

  def store_breakdown
    stores_hash = {}
    self.array_of_stores.each do |store|
      stores_hash[store] = num_of_visits_at(store)
    end
    return stores_hash
  end

  def array_of_stores
    return self.visited_stores.map(&:name).uniq
  end

  def num_of_visits_at(store_name)
    @store = Store.where("name like ?", "#{store_name}").first
    return self.visits.where("store_id = ?", "#{@store.id}").count
  end

  def self.authenticate(username, password)
    @user = User.find_by_username(username)
    @user if @user && @user.password == password
  end

  def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(password)
    @password = BCrypt::Password.create(password)
    self.hashed_password = @password
  end

end
