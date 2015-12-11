class Store < ActiveRecord::Base
	belongs_to :owner, class_name: "User"
	has_many :visits
	has_many :customers, through: :visits, source: :customer 

	validates_presence_of :name, :address, :latitude, :longitude, :daily_code, :owner_id

	before_validation(on: :create) do
		generate_new_daily_code if self.daily_code.nil?
	end

	def customer_breakdown
		customer_hash = {}
		array_of_customers.each do |customer|
			customer_hash[customer] = num_of_visits_from(customer)
		end
		return customer_hash
	end

	def array_of_customers
		return self.customers.map(&:username).uniq
	end

	def num_of_visits_from(user_name)
		@user = User.where("username like ?", "#{user_name}").first
		return self.visits.where("customer_id = ?", "#{@user.id}").count
	end

	def generate_new_daily_code(code = generate_4_digit_string)
		self.daily_code = code
	end

	private

	def generate_4_digit_string
		string = ""
		4.times { string += ([0,1,2,3,4,5,6,7,8,9].sample).to_s }
		return string
	end


end
